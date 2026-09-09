# Re entering a Docker container after first use

> **Note**: You must have already completed the [setup instructions](docker_setup.md).
## Re-entry for VS-Code

<details>
<summary><b>Windows / macOS</b></summary>

- Open Docker Desktop and wait for it to finish starting. The container will not show up until the engine is running.
- Open VS Code and go to the Dev Containers extension. The container should be there. Click on the arrow to enter the container.

![Dev Containers Extension Location](/assets/Dev%20Containers.png)

> **Note**: If you cloned into a named volume, the repo will not appear in your normal "Recent Folders" list — always re-enter through the Dev Containers extension.

</details>

<details>
<summary><b>Linux</b></summary>

- Make sure the Docker daemon is active. It normally starts on boot, but you can check with `docker info` and start it with `sudo systemctl start docker` if needed.
- Open VS Code and go to the Dev Containers extension. The container should be there. Click on the arrow to enter the container.

![Dev Containers Extension Location](/assets/Dev%20Containers.png)

</details>

## Re-entry for CLI

There is nothing to rebuild. The image persists between sessions, and `scripts/dev.sh` reuses the cached layers — if the `Dockerfile` changed since last time, the rebuild happens automatically and only the changed layers are redone. Start the engine, then re-run the script.

<details>
<summary><b>Windows</b></summary>

- Open Docker Desktop and wait for it to finish starting.
- Open a **WSL2** terminal — not PowerShell or Command Prompt — and navigate to the repo inside the WSL2 filesystem (for example `~/<repo>`).

```bash
cd ~/<repo>
./scripts/dev.sh
```

</details>

<details>
<summary><b>macOS</b></summary>

- Open Docker Desktop and wait for it to finish starting.

```bash
cd <repo>
./scripts/dev.sh
```

</details>

<details>
<summary><b>Linux</b></summary>

- Make sure the Docker daemon is active. It normally starts on boot, but you can check with `docker info` and start it with `sudo systemctl start docker` if needed.

```bash
cd <repo>
./scripts/dev.sh
```

</details>

> **Note**: The container runs with `--rm`, so it is deleted the moment you `exit` — old containers never pile up. Your work is safe because `/ws` is a bind mount onto the repo, but anything you installed by hand inside the container (`apt install`, `pip install`) is gone on exit. If you need a package permanently, add it to the `Dockerfile` so everyone else gets it too.