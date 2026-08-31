Before embarking on this journey, ensure you comply with following requirements:
- Knowledge of how to open and use the terminal on your computer
- VS Code or, alternatively, a text editor you are comfortable with
- [Git installed on your system](https://git-scm.com/install/) 
- Basic knowledge of C++ programming and compilation

# Setting up SSH authentication

All [Git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) on our repositories use SSH URLs. SSH links are advantageous, since no personal access tokens (PATs) are required.

Follow the [offical GitHub SSH tutorial](https://docs.github.com/en/authentication/connecting-to-github-with-ssh) through the "Test your connection" step.

# Setting up Docker

We rely on containerized environments for maximum portability across operating systems and consistency across the team.
Choose the setup that matches your workflow:

- [VS Code Workflow](#setting-up-docker-for-vscode)
- [CLI Workflow](#setting-up-docker-for-cli)

> **Note**: [Podman](https://podman.io/) is an alternative container engine with some key benefits (rootless by default, systemd integration). You are welcome to use Podman if you prefer, but Docker is the primary standard for this guide. I would recommend it in a Linux CLI workflow.

## Setting up Docker for VSCode

### Install VS Code 

- If you don't already have VS Code instlled, install it for your os [here](https://code.visualstudio.com/Download?_exp_download=fb315fc982).

### Install docker

- On windows or Mac OS install [Docker Desktop](https://www.docker.com/products/docker-desktop/).
- On linux install the [Docker Engine](https://docs.docker.com/engine/install/).

Once you have installed Docker check if its active by running `docker info` in a terminal. If that does not print "Cannot connect to the Docker daemon", "error during connect" or some error, and insted prints a bunch of info you are good to move on.

### Setting up the repo 

- Clone the repo and open it in VS Code.
- Install [Dev Containers extention](vscode:extension/ms-vscode-remote.remote-containers) for VS Code (open this link in vscode).
- Open in the container by running this VS Code comamnd `>Dev Containers: Reopen in Container` (you can quickly open the search bar with the `>` by pressing Ctrl+Shift+P, or Cmd+Shift+P on Mac). This will build the container for a while and then put you inside the contaner.
![How to run VS Code commands](./assets/VS%20Code%20comands.png)

- Test building code by running 
``` bash
cd Setup
cmake -B build
cmake --build build
cd ../
```
- Run the program with `./Setup/build/hello`, and you should get `"Hello World"`.

### Re entering the container after first use.

- Make sure Docker is active
- Open VS Code and go to the Dev Containers extention. The contaner should be there. Click on the arrow to enter the container.
![Dev Containers Extention Location](./assets/Dev%20Containers.png)

## Setting up Docker for CLI

Before specific instructions on how we use containers, install either [Docker](https://docs.docker.com/engine/install/) or [Podman](https://podman.io/docs/installation). 

smth using the `Setup` materials
