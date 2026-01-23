# OpenCode Sandbox

A containerized sandbox environment for running OpenCode AI in an isolated Docker container.

## Prerequisites

- Docker installed and running on your system
- Make (optional, for using Makefile commands)
- OpenCode configuration files in your home directory (`~/.opencode` or `~/.config/opencode`)

## What's Included

This sandbox provides:
- **Node.js LTS** (slim variant)
- **OpenCode AI** (globally installed via npm)
- **Git** for version control
- **curl** for HTTP requests
- **jq** for JSON processing
- **dumb-init** for proper signal handling

## Building the Sandbox

### Using Make (Recommended)

```bash
make build
```

### Using Docker Directly

```bash
docker build -t opencode-sandbox .
```

## Running the Sandbox

### Using Make (Recommended)

```bash
make run
```

### Using Docker Directly

```bash
bash docker-run.sh
```

## Installation as Shell Alias

For easy access from anywhere on your system, install the sandbox as a shell alias:

### Quick Install

1. **Build the image:**
   ```bash
   make build
   ```

2. **Install the alias** (choose your shell):
   ```bash
   # For bash
   make install-bash
   
   # For zsh
   make install-zsh
   ```

3. **Reload your shell:**
   ```bash
   source ~/.bashrc  # or source ~/.zshrc
   ```

4. **Use it from anywhere:**
   ```bash
   cd ~/my-project
   opencode-sandbox
   ```

### Uninstall

To remove the alias:
```bash
make uninstall-bash  # or make uninstall-zsh
```

To remove the Docker image:
```bash
docker rmi opencode-sandbox
```

## Volume Mounts Explained

The sandbox mounts several directories to integrate with your host system:

| Host Path | Container Path | Mode | Purpose |
|-----------|---------------|------|---------|
| `$(pwd)` | `/workspace` | rw | Working directory for your projects |
| `~/.opencode` | `/home/node/.opencode` | ro | OpenCode configuration (read-only) |
| `~/.config/opencode` | `/home/node/.config/opencode` | ro | OpenCode config files (read-only) |
| `~/.local/share/opencode` | `/home/node/.local/share/opencode` | rw | OpenCode data storage |
| `~/.cache/opencode` | `/home/node/.cache/opencode` | rw | OpenCode cache |
| `~/.local/state/opencode` | `/home/node/.local/state/opencode` | rw | OpenCode state files |

## Security Features

- Runs as non-root user (`node`)
- All Linux capabilities dropped (`--cap-drop=ALL`)
- Bridge networking for controlled network access
- Configuration files mounted read-only where appropriate

## Working Inside the Sandbox

Once inside the container:

```bash
# Check available tools
git --version
node --version
npm --version
curl --version

# OpenCode should start automatically
# Your current directory is mounted at /workspace
```

## Configuring Git (Optional)

If you plan to make commits within the sandbox:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## Troubleshooting

### OpenCode config not found
Ensure you have OpenCode configured on your host system before running the sandbox.

### Permission issues
The container runs as the `node` user (UID 1000). Ensure your mounted directories are accessible.

### Network issues
The sandbox uses bridge networking. If you need specific network configurations, modify the `--network` flag.

## Customization

To add additional tools or modify the environment, edit the `Dockerfile` and rebuild:

```dockerfile
# Add your custom packages
RUN apt-get update && apt-get install -y \
    your-package-here \
    && rm -rf /var/lib/apt/lists/*
```

Then rebuild with `make build` or `docker build -t opencode-sandbox .`
