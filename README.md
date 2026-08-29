Before embarking on this journey, I want to outline what you are expected to have before following this tutorial:
- Knowledge of how to open and use the terminal on your computer
- A IDE or text editor you are comfortable with (ie. VSCode)
- [Git installed on your system](https://git-scm.com/install/) 
- Basic knowledge of C++ programming and compilation

## Setting up SSH authentication

All [git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) on our repos use SSH URLs which require some setup that we will do below. The reason for this is that once the initial setup is complete, SSH links are advantageous, since no PAT is required.

Follow the [offical github tutorial](https://docs.github.com/en/authentication/connecting-to-github-with-ssh) until "Test your connection step".

## Setting up Docker

  Follow either the [vscode setup](#setting-up-docker-for-vscode) or the [cli workflow setup](#setting-up-docker-for-cli)

  One can also use [podman](https://podman.io/) rather than docker, which is what I do. The main benefits being some saner defaults and increased security at the cost of it being a less standard tool. You might encounter slight differences from docker, but should generally be very similar.

### Setting up Docker for VSCode

    

### Setting up Docker for CLI
