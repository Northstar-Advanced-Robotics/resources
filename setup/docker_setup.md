# Setting up Docker

We rely on containerized environments for maximum portability across operating systems and consistency across the team.

This guide covers the parts that are the same for every repo. Anything repo-specific — the image name, the exact run command, and how to verify the build — comes from the setup doc that linked you here. Keep that doc open alongside this one.

Choose the setup that matches your workflow:

- [VS Code Workflow](#setting-up-docker-for-vscode)
- [CLI Workflow](#setting-up-docker-for-cli)

Already set up once and just need to get back in? See [Re entering a container](docker_re-entry.md).

> **Note**: [Podman](https://podman.io/) is an alternative container engine with some key benefits (rootless by default, systemd integration). You are welcome to use Podman if you prefer, but Docker is the primary standard for this guide. I would recommend it in a Linux CLI workflow.

## Setting up Docker for VSCode

### Installing VS Code

- If you don't already have VS Code installed, install it for your os [here](https://code.visualstudio.com/Download?_exp_download=fb315fc982).

### Installing Docker

<details>
<summary><b>Windows</b></summary>

Install [Docker Desktop](https://www.docker.com/products/docker-desktop/) and make sure the WSL2 backend is enabled during setup.

</details>

<details>
<summary><b>macOS</b></summary>

Install [Docker Desktop](https://www.docker.com/products/docker-desktop/).

</details>

<details>
<summary><b>Linux</b></summary>

Install the [Docker Engine](https://docs.docker.com/engine/install/).

</details>

Once you have installed Docker check if it's active by running `docker info` in a terminal. If that does not print "Cannot connect to the Docker daemon", "error during connect" or some error, and instead prints a bunch of info you are good to move on.

### Setting up the repo

On Windows and macOS the container runs inside a Linux VM, so a normal clone on your host filesystem has to be shared across that VM boundary. Every file read and write becomes a round trip, which makes compiles several times slower and stops file-change notifications from reaching the container — git and VS Code will miss edits or fall back to slow polling. Cloning directly into a Docker volume keeps the source inside the VM and avoids both problems.

Pick the instructions for your OS:

<details>
<summary><b>Windows / macOS — clone into a named volume (recommended)</b></summary>

- Install the [Dev Containers extension](vscode:extension/ms-vscode-remote.remote-containers) for VS Code (open this link in VS Code).
- Open the command palette with `Ctrl+Shift+P` (`Cmd+Shift+P` on Mac) and run:
```
>Dev Containers: Clone Repository in Named Volume...
```


- Paste the repo URL when prompted, then accept the default volume and folder names. VS Code will create the volume, clone into it, build the container, and open you inside it. This will take a few minutes.
- Your git credentials and SSH agent are forwarded automatically, so pushing and pulling from inside the container works as normal.

> **Note**: The files live in the Docker volume, not on your host. You can only reach them through VS Code or a shell inside the container — host-side editors and GUI git clients will not see them. Deleting the volume (`docker volume rm`) permanently deletes anything you have not pushed, so commit and push before cleaning up containers.

</details>

<details>
<summary><b>Windows — alternative: clone inside WSL2</b></summary>

If you would rather keep the files reachable from the host, clone into the WSL2 filesystem instead of `C:\`. From a WSL2 terminal:

```bash
cd ~
git clone <repo-url>
code <repo-name>
```

Files under `\\wsl$\<distro>\home\<you>\` stay inside the VM, so builds are fast and file watching works, while Explorer and host git tools can still reach them. Do not clone to a path under `/mnt/c` — that is the slow path this section is warning about.

- `code <repo-name>` opens VS Code already connected to WSL. The bottom-left corner should read `WSL: <distro>`.
- Install the [Dev Containers extension](vscode:extension/ms-vscode-remote.remote-containers) for VS Code (open this link in VS Code). If you already had it installed on Windows, VS Code will prompt you to install it in the WSL remote as well — accept.
- Open the command palette with `Ctrl+Shift+P` and run:
```
>Dev Containers: Reopen in Container
```
- Wait for the container to build. When its done you should be good.

</details>

<details>
<summary><b>Linux — clone normally</b></summary>

There is no VM boundary on Linux, so a bind mount is just a bind mount.

- Clone the repo and open it in VS Code.
- Install the [Dev Containers extension](vscode:extension/ms-vscode-remote.remote-containers) for VS Code (open this link in VS Code).
- Open the command palette with Ctrl+Shift+P (Cmd+Shift+P on Mac) and run:
```
>Dev Containers: Reopen in Container
```
- Wait for the container to build. When its done you should be good.

</details>
<br>

Once you are inside the container, follow the build and verification steps in the repo's own setup doc.

## Setting up Docker for CLI

Make sure either [Docker](https://docs.docker.com/engine/install/) or [Podman](https://podman.io/docs/installation) is installed.
> **Note**: If using podman, replace `docker` with `podman` in all commands shown below. `scripts/dev.sh` detects podman on its own.

> **Note for Windows**: Run these commands from a WSL2 shell with the repo cloned inside the WSL2 filesystem (for example `~/<repo>`), not from `/mnt/c`. Bind mounting a Windows drive into the container is significantly slower and breaks file-change detection.

### Entering the Container

Every repo has a `scripts/dev.sh` that builds the image and drops you into a shell with the right flags already applied:

```bash
git clone <repo-url>
cd <repo-name>
./scripts/dev.sh
```

You can also run a single command inside the container without staying there:

```bash
./scripts/dev.sh cmake --build build
```

That is all most people need. The rest of this section explains what the script does, which is worth reading once so you can debug it when something goes wrong.

### What the script is doing

First it builds an image from the repo's `Dockerfile`:

```bash
docker build -t <image-name>:<tag> -f .devcontainer/Dockerfile .
```

Image names follow the `<repository>:<tag>` format, where tag specifies the version of the image. To verify the image was built successfully, run `docker image ls`, which lists all images on your system. Rebuilding is cheap once the layers are cached, which is why the script does it every time — it means a changed `Dockerfile` is always picked up.

Then it starts a container from that image:

```bash
docker run -it --rm -v .:/ws -w /ws <image-name>:<tag> bash
```

To explain the run command briefly:
- `-it`: Allocates a pseudo-TTY and forwards STDIN to provide an interactive shell.
- `--rm`: Automatically deletes the container once you `exit`.
- `-v .:/ws`: Mounts the current working directory on the host to `/ws` inside the container.
- `-w /ws`: Sets `/ws` as the working directory once you enter the container.
- `<image-name>:<tag>`: Specifies the image you are running.
- `bash`: The program to execute on entry.

Because the source is bind mounted, edits you make on the host show up in the container immediately and anything you build in the container lands on the host. Files created inside the container are owned by the container user, so you may need to `chown` them if you hit permission errors on the host.

### Repo-specific flags

Some repos need extra flags to reach hardware or the network — `--network=host` for ROS 2 discovery, `--device=/dev/ttyUSB0` for a serial device, X11 forwarding for GUI tools. These live in two places:

- `RUN_FLAGS` in `scripts/dev.sh`, for this workflow.
- `runArgs` in `.devcontainer/devcontainer.json`, for the VS Code workflow.

**If you add a flag to one, add it to the other.** Both files carry a comment pointing at the other. Do not add flags to the `docker run` line by hand for anything permanent — put it in the script so everyone gets it.

### Building

With the environment set up, build and verify using the steps in the repo's setup doc. You can leave the container at any time by entering `exit`.

> **Note for Fedora/RHEL**: Bind mounts need `:Z` appended to the volume flag (`-v .:/ws:Z`) to properly label the SELinux security context. `scripts/dev.sh` detects SELinux and adds this for you; you only need it if you are running `docker run` by hand.