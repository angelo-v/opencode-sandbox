#!/usr/bin/env nu
const PI_LSP_VERSION = "0.1.7"

def main [] {
    let agent_dir = $env.PI_CODING_AGENT_DIR? | default "/home/node/.pi/agent"
    let lsp_template = $env.PI_LSP_TEMPLATE? | default "/usr/local/share/pi-sandbox/lsp.json"
    let lsp_config = $agent_dir | path join "lsp.json"
    let settings = $agent_dir | path join "settings.json"

    if not ($lsp_config | path exists) {
        print $"[pi] Seeding LSP config at ($lsp_config) ..."
        mkdir $agent_dir
        cp $lsp_template $lsp_config
    }

    let pkg = $"npm:pi-lsp@($PI_LSP_VERSION)"
    let already_installed = ($settings | path exists) and (open --raw $settings | str contains "npm:pi-lsp")
    if not $already_installed {
        print $"[pi] Installing pi-lsp extension: ($pkg)"
        try {
            ^pi install $pkg
        } catch {
            print -e "[pi] WARNING: pi-lsp installation failed — continuing without LSP support."
        }
    }
}
