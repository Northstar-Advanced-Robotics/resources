Before embarking on this journey, ensure you comply with following requirements:
- Knowledge of how to open and use the terminal on your computer
- VS Code or, alternatively, a text editor you are comfortable with
- [Git installed on your system](https://git-scm.com/install/) 
- Basic knowledge of C++ programming and compilation

## Setting up SSH authentication

All [Git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) on our repositories use SSH URLs. SSH links are advantageous, since no personal access tokens (PATs) are required.

Follow the [offical GitHub SSH tutorial](https://docs.github.com/en/authentication/connecting-to-github-with-ssh) through the "Test your connection" step.

## Setting up Docker

We rely on containerized environments for maximum portability across operating systems and consistency across the team.
Choose the setup that matches your workflow:

- [VS Code Workflow](#setting-up-docker-for-vscode)
- [CLI Workflow](#setting-up-docker-for-cli)

> **Note**: [Podman](https://podman.io/) is an alternative container engine with some key benefits (rootless by default, systemd integration). You are welcome to use Podman if you prefer, but Docker is the primary standard for this guide. I would recommend it in a Linux CLI workflow.

### Setting up Docker for VSCode

smth using the `Setup` materials

### Setting up Docker for CLI

Before specific instructions on how we use containers, install either [Docker](https://docs.docker.com/engine/install/) or [Podman](https://podman.io/docs/installation). 

smth using the `Setup` materials
