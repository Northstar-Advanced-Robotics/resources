# Sentry Intro 

Make sure you have these 2 complete before following the rest of the guide.
- [SSH setup](/setup/ssh.md)
- [Docker setup](/setup/docker.md)

## Intro to ROS2

[ROS](https://www.ros.org/) (Robot Operating System) is an open-source ecosystem that provides framework, tools, and libraries for building, deploying, running, and maintaining robotic applications.

This repo contains a quick tutorial on ROS2 to help you get up to speed with the team, but if you ever want to dive deeper, you can head over to the [official docs](https://docs.ros.org/en/jazzy/About-ROS.html) to learn more.

## Basic Structure

ROS2 programs, called **Nodes**, usually have one specific job, such as dealing with vision, uart communication, apriltag detection, etc.
We orchestrate all these granular nodes together to build a fully complete, autonomous robot.

**ROS2 Graphs**, a group of nodes, are orchestrated by **Launch Files**. These specify which and how nodes are run.

Nodes communicate over **Topics**, which act as message queues of predetermined message formats. Concrete message formats allow easy integration of third-party packages.

### ROS2 workspace

The basic layout of a ROS2 workspace looks like this:
```text
<workspace root>
├── build
├── install
├── log
└── src
    ├── <package>
    ├── <package>
    └── ...

```
- `build` contains all the build artifacts. You don't have to look there unless you are debugging the build. 
- `install` is the final clean output of building
- `log` stores all the build logs
- `src` is where all the source code lives. It is organized by package, which can be thought of as separate smaller projects

`build`, `install`, and `log` are not tracked in git, since they are all byproducts of building the source code. 

### ROS2 packages
ROS2 packages follow this convention:
```text
<package>
├── CMakeLists.txt
├── config
│   └── <config files>.yaml
├── include
│   └── <package-name>
│       └── <public headers>.h
├── launch
│   └── <launch files>.py
├── package.xml
└── src
    └── <C++ sources>.cpp
```
