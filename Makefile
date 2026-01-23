build:
	docker build -t opencode-sandbox .

run:
	@bash docker-run.sh

install-bash:
	@echo "Installing opencode-sandbox alias for bash..."
	@echo "alias opencode-sandbox='$$(cat docker-run.sh)'" >> ~/.bashrc
	@echo "✓ Alias added to ~/.bashrc"
	@echo "Run: source ~/.bashrc (or restart your terminal)"

install-zsh:
	@echo "Installing opencode-sandbox alias for zsh..."
	@echo "alias opencode-sandbox='$$(cat docker-run.sh)'" >> ~/.zshrc
	@echo "✓ Alias added to ~/.zshrc"
	@echo "Run: source ~/.zshrc (or restart your terminal)"

uninstall-bash:
	@echo "Removing opencode-sandbox alias from bash..."
	@sed -i.bak '/alias opencode-sandbox=/d' ~/.bashrc
	@echo "✓ Alias removed from ~/.bashrc (backup: ~/.bashrc.bak)"

uninstall-zsh:
	@echo "Removing opencode-sandbox alias from zsh..."
	@sed -i.bak '/alias opencode-sandbox=/d' ~/.zshrc
	@echo "✓ Alias removed from ~/.zshrc (backup: ~/.zshrc.bak)"

.PHONY: run build install-bash install-zsh uninstall-bash uninstall-zsh

