# Windows Docker Kit (WDK)

Welcome to the Windows Docker Kit (WDK) repository! This project provides Docker-based solutions for running Windows applications on non-Windows environments, with a focus on WeChat and other Win32 applications.

## Table of Contents

1. [Overview](#overview)
2. [Repository Structure](#repository-structure)
3. [Projects](#projects)
   - [WDK-405b](#wdk-405b)
   - [WDK-Claude](#wdk-claude)
   - [WDK-GPT](#wdk-gpt)
4. [Getting Started](#getting-started)
5. [Contributing](#contributing)
6. [License](#license)

## Overview

The Windows Docker Kit (WDK) is a collection of Docker configurations and scripts designed to run Windows applications in containerized environments. This project aims to provide easy-to-use solutions for running applications like WeChat on various platforms, including ARM-based systems.

## Repository Structure

```
└── ./
    ├── wdk-405b/
    ├── wdk-claude/
    ├── wdk-gpt/
    └── README.md (this file)
```

## Projects

### WDK-405b

WDK-405b is a Docker container solution for running Win32 apps on a Linux system using Wine. It includes support for VNC and noVNC for remote access.

[Learn more about WDK-405b](./wdk-405b/README.md)

### WDK-Claude

WDK-Claude provides a Docker environment for running Windows applications (such as WeChat) using Wine, with a web-based VNC interface for easy access. It uses Xvfb for a virtual display and noVNC for browser-based remote access.

[Learn more about WDK-Claude](./wdk-claude/README.md)

### WDK-GPT

WDK-GPT is a Wine-based Docker environment specifically tailored for running WeChat. It supports ARM64 architecture and provides access to the container's GUI through a web browser or VNC client.

[Learn more about WDK-GPT](./wdk-gpt/README.md)

## Getting Started

To get started with any of the WDK projects:

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/windows-docker-kit.git
   cd windows-docker-kit
   ```

2. Choose the project you want to use (wdk-405b, wdk-claude, or wdk-gpt).

3. Follow the README instructions in the respective project folder for building and running the Docker container.

## Contributing

We welcome contributions to the Windows Docker Kit! If you have suggestions for improvements or bug fixes, please feel free to submit an issue or pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.
