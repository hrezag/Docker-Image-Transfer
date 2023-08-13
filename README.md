
# Docker Image Transfer

A Bash script for managing Docker images by providing functionalities for saving, loading, and transferring images.

## Table of Contents

- [Description](#description)
- [Usage](#usage)
- [Options](#options)
- [Requirements](#requirements)
- [License](#license)

## Description

The Docker Image Transfer script simplifies the management of Docker images. It offers the ability to save all Docker images, load images from files, and transfer images to a destination server using SCP.

## Usage

Execute the script in a terminal to choose from the available options.

```bash
./docker-Image-transfer.sh
```
## Options

The script provides the following options:

-   `save`: Save all Docker images to the current directory.
-   `load`: Find and import Docker images from files.
-   `transfer`: Transfer Docker images to a destination server using SCP. When choosing this option, the script will prompt you for the destination server's username, password, and address.

To select an option, run the script without any arguments and use the provided menu.

## Requirements

-   Docker: Ensure Docker is installed and properly configured on your system.

## License

This project is licensed under the [MIT License](https://opensource.org/license/mit/).
