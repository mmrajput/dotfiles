# dotfiles

Personal developer environment for homelab infrastructure management.
Provides a reproducible, containerised CLI environment for Kubernetes, Helm, ArgoCD, Ansible, and related tooling.

## Structure

```
dotfiles/
├── .devcontainer/
│   ├── Dockerfile          # Container image definition
│   ├── devcontainer.json   # Mounts, network, env config
│   └── post-create.sh      # Runs once after container creation
├── shell/
│   └── bashrc              # Shell config: prompt, aliases, kubectl completion
├── scripts/
│   └── dev-shell.sh        # Entry point: start container + open login shell
└── README.md
```

## Tools included

| Tool | Version | Purpose |
|------|---------|---------|
| kubectl | 1.31.4 | Kubernetes CLI (CKA exam version) |
| kubeadm | 1.31.4 | Cluster bootstrap |
| helm | 3.16.3 | Kubernetes package manager |
| argocd | 2.13.2 | GitOps CLI |
| etcdctl | 3.5.17 | etcd CLI (CKA exam requirement) |
| crictl | 1.31.1 | Container runtime CLI (CKA exam requirement) |
| k9s | 0.32.7 | Kubernetes TUI |
| yq | 4.44.6 | YAML processor |
| ansible | 10.7.0 | Infrastructure automation |
| diagrams | 0.24.4 | Architecture-as-code |

## Setup

### Prerequisites

- WSL2 (Ubuntu)
- Docker Desktop with WSL2 backend
- devcontainer CLI: `npm install -g @devcontainers/cli`

### First-time setup

```bash
# Clone dotfiles
git clone git@github.com:mmrajput/dotfiles.git ~/dotfiles

# Add dcs alias to WSL ~/.bashrc
echo 'alias dcs="bash ~/dotfiles/scripts/dev-shell.sh"' >> ~/.bashrc
source ~/.bashrc

# Start the container
dcs
```

### New machine setup

```bash
git clone git@github.com:mmrajput/dotfiles.git ~/dotfiles && dcs
```

## Usage

```bash
# Start container and open shell
dcs

# All repos are available at /workspaces
cd /workspaces/kubernetes-single-cluster
cd /workspaces/another-repo
```

## Repos mountpoint

All repos under `/mnt/d/TechLabs/GitHubRepos` on the WSL host are bind-mounted
to `/workspaces` inside the container. No rebuild needed when adding new repos.
