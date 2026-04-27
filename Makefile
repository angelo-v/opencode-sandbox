build:
	docker build -t opencode-sandbox .

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

.PHONY: run build install-bash install-zsh uninstall-bash uninstall-zsh

