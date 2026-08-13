#!/bin/bash
set -euo pipefail

GNUPGHOME="/home/node/.pi/gnupg"
PASSWORD_STORE_DIR="/home/node/.pi/secrets"
export GNUPGHOME PASSWORD_STORE_DIR

# Sicherstellen dass die Verzeichnisse existieren und korrekte Berechtigungen haben
mkdir -p "$GNUPGHOME" "$PASSWORD_STORE_DIR"
chmod 700 "$GNUPGHOME"

# GPG-Schlüssel erzeugen falls noch keiner vorhanden
if ! gpg --list-secret-keys pi@local &>/dev/null; then
    echo "[pi] No GPG key found — generating new Ed25519 key..."

    gpg --batch --gen-key <<EOF
%no-protection
Key-Type: EDDSA
Key-Curve: ed25519
Key-Usage: sign
Subkey-Type: ECDH
Subkey-Curve: cv25519
Subkey-Usage: encrypt
Name-Real: Pi Agent
Name-Email: pi@local
Expire-Date: 0
%commit
EOF

    echo "[pi] GPG key created successfully."
fi

# password-store initialisieren falls noch nicht geschehen
if [ ! -f "$PASSWORD_STORE_DIR/.gpg-id" ]; then
    echo "[pi] Initialising password store at $PASSWORD_STORE_DIR ..."
    GPG_ID=$(gpg --list-keys --with-colons pi@local | awk -F: '/^fpr:/{print $10; exit}')
    pass init "$GPG_ID"
    echo "[pi] Password store initialised."
fi

# LSP-Setup
nu --no-config-file /usr/local/share/pi-sandbox/setup-lsp.nu

exec "$@"
