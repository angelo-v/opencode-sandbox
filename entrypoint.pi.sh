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
    echo "[pi] Kein GPG-Schlüssel gefunden — erzeuge neuen Ed25519-Schlüssel..."

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

    echo "[pi] GPG-Schlüssel erfolgreich erzeugt."
else
    echo "[pi] GPG-Schlüssel gefunden — wird wiederverwendet."
fi

# password-store initialisieren falls noch nicht geschehen
if [ ! -f "$PASSWORD_STORE_DIR/.gpg-id" ]; then
    echo "[pi] Initialisiere password-store unter $PASSWORD_STORE_DIR ..."
    GPG_ID=$(gpg --list-keys --with-colons pi@local | awk -F: '/^fpr:/{print $10; exit}')
    pass init "$GPG_ID"
    echo "[pi] password-store initialisiert."
else
    echo "[pi] password-store bereits initialisiert."
fi

exec "$@"
