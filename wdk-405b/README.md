# Win32 App Docker Container

This Docker container allows you to run Win32 apps on a Linux system using Wine.

## Table of Contents
- [Building the Container](#building-the-container)
- [Running the Container](#running-the-container)
- [Customizing the Container](#customizing-the-container)
- [Environment Variables](#environment-variables)
- [VNC Connection](#vnc-connection)
- [Troubleshooting](#troubleshooting)
- [License](#license)
- [Credits](#credits)
- [Contributing](#contributing)

## Building the Container

To build the container, run the following command:

```bash
docker build -t my-win32-app-image .
```

This will create a Docker image with the name `my-win32-app-image`.

## Running the Container

To run the container, use the following command:

```bash
docker run -it --rm my-win32-app-image
```

This will start a new container from the `my-win32-app-image` image and run the default command `/root/start_win32_app.sh WeChat`.

## Customizing the Container

You can customize the container by passing a different argument to the `start_win32_app.sh` script. For example:

```bash
docker run -it --rm my-win32-app-image Notepad
```

This will start a new container and run the `Notepad` app instead of the default `WeChat` app.

## Environment Variables

You can also set environment variables to customize the container. For example:

```bash
docker run -it --rm -e WIN32_APP=Notepad my-win32-app-image
```

This will set the `WIN32_APP` environment variable to `Notepad` and run the `Notepad` app.

## VNC Connection

To connect to the container using VNC, use the following command:

```bash
docker run -it --rm -p 6080:6080 my-win32-app-image
```

This will start a new container and map port 6080 on the host machine to port 6080 in the container. You can then connect to the container using a VNC client.

## Troubleshooting

If you encounter any issues with the container, you can check the logs using the following command:

```bash
docker logs -f my-win32-app-image
```

This will show you the latest logs from the container.

## License

This Docker container is licensed under the MIT License.

## Credits

This Docker container was created by [Your Name].

## Contributing

If you would like to contribute to this Docker container, please fork the repository and submit a pull request.
