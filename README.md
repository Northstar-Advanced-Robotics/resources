# Welcome to the Sentry Intro project!

### Prerequisites
Before jumping in, make sure you have the basics ready:
- **Terminal literacy**: Comfortable opening terminal and running basic commands.
- **C++ basics**: Basic knowledge of C++ programming and compilation.
- **Text Editor**: VS Code or, alternatively, a text editor you are comfortable with.
- **Git**: [Installed on your system](https://git-scm.com/install/).

## Setting up SSH authentication

All [Git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) on our repositories use SSH URLs. SSH links are advantageous, since no personal access tokens (PATs) are required.

Follow the [official GitHub SSH tutorial](https://docs.github.com/en/authentication/connecting-to-github-with-ssh) through the "Test your connection" step.

## Setting up Docker

We rely on containerized environments for maximum portability across operating systems and consistency across the team.
Choose the setup that matches your workflow:

- [VS Code Workflow](#setting-up-docker-for-vscode)
- [CLI Workflow](#setting-up-docker-for-cli)

> **Note**: [Podman](https://podman.io/) is an alternative container engine with some key benefits (rootless by default, systemd integration). You are welcome to use Podman if you prefer, but Docker is the primary standard for this guide. I would recommend it in a Linux CLI workflow.

### Setting up Docker for VSCode

#### Installing VS Code 

- If you don't already have VS Code installed, install it for your os [here](https://code.visualstudio.com/Download?_exp_download=fb315fc982).

#### Installing Docker

- On windows or Mac OS install [Docker Desktop](https://www.docker.com/products/docker-desktop/).
- On linux install the [Docker Engine](https://docs.docker.com/engine/install/).

Once you have installed Docker check if it's active by running `docker info` in a terminal. If that does not print "Cannot connect to the Docker daemon", "error during connect" or some error, and instead prints a bunch of info you are good to move on.

#### Setting up the repo 

- Clone the repo and open it in VS Code.
- Install [Dev Containers extension](vscode:extension/ms-vscode-remote.remote-containers) for VS Code (open this link in vscode).
- Open in the container by running this VS Code comamnd `>Dev Containers: Reopen in Container` (you can quickly open the search bar with the `>` by pressing Ctrl+Shift+P, or Cmd+Shift+P on Mac). This will build the container for a while and then put you inside the contaner.
![How to run VS Code commands](./assets/VS%20Code%20comands.png)

- Test building code by running 
``` bash
cd Setup
cmake -B build
cmake --build build
cd ../
```
- Run the program with `./Setup/build/hello`, and you should get `Congratulations! You have completed the setup`.

#### Re entering the container after first use.

- Make sure Docker is active
- Open VS Code and go to the Dev Containers extension. The container should be there. Click on the arrow to enter the container.
![Dev Containers Extension Location](./assets/Dev%20Containers.png)

### Setting up Docker for CLI

 Make sure either [Docker](https://docs.docker.com/engine/install/) or [Podman](https://podman.io/docs/installation) is installed.
> **Note**: If using podman, replace `docker` with `podman` in all commands shown below.

Once Docker is installed you can proceed with building the image, which is as simple as:
```bash
cd Setup
docker build -t sentry:setup . 
```
Image names follow the `<repository>:<tag>` format, where tag specifies the version of the image.
To verify the image was built successfully, run `docker image ls`, which lists all images on your system.

Now that you have the image built, you can run it with the following command:
```bash
docker run -it --rm -v .:/ws -w /ws sentry:setup bash
```
Which should drop you right onto a bash shell inside the container with all the `Setup` files mounted at `/ws`. 

To explain the run command briefly:
- `-it`: Allocates a pseudo-TTY and forwards STDIN to provide an interactive shell.
- `--rm`: Automatically deletes the container once you `exit`.
- `-v .:/ws`: Mounts the current working directory on the host to `/ws` inside the container.
- `-w /ws`: Sets `/ws` as the working directory once you enter the container.
- `sentry:setup`: Specifies the image you are running.
- `bash`: The program to execute on entry.
> **Note for Fedora/RHEL**: If you are having permission issues with the mounted files, append `:Z` to the volume flag (`-v .:/ws:Z`) to properly label the SELinux security context.

With the environment set up, you can configure, compile and run `Setup/main.cpp` using the following commands:
```bash
cmake -B build
cmake --build build
build/hello
```
The output of the commands should end with `Congratulations! You have completed the setup`. You can now leave the container by entering `exit`.
