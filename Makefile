build:
	docker build -t ghcr.io/angelo-v/opencode-sandbox:latest .

run:
	@bash docker-run.sh

install-bash:
	@echo "Installing opencode-sandbox alias for bash..."
	@sed -i.bak '/# BEGIN opencode-sandbox/,/# END opencode-sandbox/d' ~/.bashrc
	@echo "# BEGIN opencode-sandbox" >> ~/.bashrc
	@echo "alias opencode-sandbox='$$(cat docker-run.sh)'" >> ~/.bashrc
	@echo "# END opencode-sandbox" >> ~/.bashrc
	@echo "✓ Alias added to ~/.bashrc"
	@echo "Run: source ~/.bashrc (or restart your terminal)"

install-zsh:
	@echo "Installing opencode-sandbox alias for zsh..."
	@sed -i.bak '/# BEGIN opencode-sandbox/,/# END opencode-sandbox/d' ~/.zshrc
	@echo "# BEGIN opencode-sandbox" >> ~/.zshrc
	@echo "alias opencode-sandbox='$$(cat docker-run.sh)'" >> ~/.zshrc
	@echo "# END opencode-sandbox" >> ~/.zshrc
	@echo "✓ Alias added to ~/.zshrc"
	@echo "Run: source ~/.zshrc (or restart your terminal)"

uninstall-bash:
	@echo "Removing opencode-sandbox alias from bash..."
	@sed -i.bak '/# BEGIN opencode-sandbox/,/# END opencode-sandbox/d' ~/.bashrc
	@echo "✓ Alias removed from ~/.bashrc (backup: ~/.bashrc.bak)"

uninstall-zsh:
	@echo "Removing opencode-sandbox alias from zsh..."
	@sed -i.bak '/# BEGIN opencode-sandbox/,/# END opencode-sandbox/d' ~/.zshrc
	@echo "✓ Alias removed from ~/.zshrc (backup: ~/.zshrc.bak)"

# --- pi-coding-agent sandbox ---

build-pi:
	docker build -f Dockerfile.pi -t ghcr.io/angelo-v/pi-sandbox:latest .

run-pi:
	@bash pi-run.sh

install-pi-bash:
	@echo "Installing pi-sandbox alias for bash..."
	@sed -i.bak '/# BEGIN pi-sandbox/,/# END pi-sandbox/d' ~/.bashrc
	@echo "# BEGIN pi-sandbox" >> ~/.bashrc
	@echo "alias pi-sandbox='$$(cat pi-run.sh)'" >> ~/.bashrc
	@echo "# END pi-sandbox" >> ~/.bashrc
	@echo "✓ Alias added to ~/.bashrc"
	@echo "Run: source ~/.bashrc (or restart your terminal)"

install-pi-zsh:
	@echo "Installing pi-sandbox alias for zsh..."
	@sed -i.bak '/# BEGIN pi-sandbox/,/# END pi-sandbox/d' ~/.zshrc
	@echo "# BEGIN pi-sandbox" >> ~/.zshrc
	@echo "alias pi-sandbox='$$(cat pi-run.sh)'" >> ~/.zshrc
	@echo "# END pi-sandbox" >> ~/.zshrc
	@echo "✓ Alias added to ~/.zshrc"
	@echo "Run: source ~/.zshrc (or restart your terminal)"

uninstall-pi-bash:
	@echo "Removing pi-sandbox alias from bash..."
	@sed -i.bak '/# BEGIN pi-sandbox/,/# END pi-sandbox/d' ~/.bashrc
	@echo "✓ Alias removed from ~/.bashrc (backup: ~/.bashrc.bak)"

uninstall-pi-zsh:
	@echo "Removing pi-sandbox alias from zsh..."
	@sed -i.bak '/# BEGIN pi-sandbox/,/# END pi-sandbox/d' ~/.zshrc
	@echo "✓ Alias removed from ~/.zshrc (backup: ~/.zshrc.bak)"

secrets-pi:
	@echo "Starte pi-secrets-shell — 'pass insert <name>' zum Hinzufügen von Secrets..."
	@docker run -it --rm \
	  --cap-drop=ALL \
	  --network=host \
	  -v $(HOME)/.pi:/home/node/.pi:rw \
	  -e GNUPGHOME=/home/node/.pi/gnupg \
	  -e PASSWORD_STORE_DIR=/home/node/.pi/secrets \
	  --entrypoint bash \
	  ghcr.io/angelo-v/pi-sandbox:latest \

.PHONY: run build install-bash install-zsh uninstall-bash uninstall-zsh \
        build-pi run-pi secrets-pi install-pi-bash install-pi-zsh uninstall-pi-bash uninstall-pi-zsh

