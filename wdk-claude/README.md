# Docker Wine noVNC Environment

This project provides a Docker environment for running Windows applications (such as WeChat) using Wine, with a web-based VNC interface for easy access. It uses Xvfb for a virtual display and noVNC for browser-based remote access.

## Prerequisites

- Docker installed on your system
- Git (optional, for cloning the repository)

## Getting Started

1. Clone this repository or download the Dockerfile and associated scripts:

   ```bash
   git clone https://github.com/yourusername/docker-wine-novnc.git
   cd docker-wine-novnc
   ```

2. Prepare the Windows fonts (optional, but recommended for better application display):
   - Create a directory named `windows_fonts` in the same directory as the Dockerfile.
   - Copy your Windows fonts (*.ttf, *.ttc) into this directory.

3. Prepare the WeChat installer:
   - Download the WeChat Windows installer.
   - Place the installer in the `scripts` directory and name it `WeChatSetup.exe`.

4. Build the Docker image:

   ```bash
   docker build -t wechat-wine .
   ```

   This process may take some time as it installs all necessary components.

5. Run the container:

   ```bash
   docker run -it --rm -p 6080:6080 wechat-wine
   ```

6. Access the virtual desktop:
   - Open a web browser and navigate to `http://localhost:6080/vnc.html`
   - If you're running this on a remote server, replace `localhost` with the server's IP address.

7. You should now see the WeChat interface in your browser. If it's the first run, the WeChat installation process will start automatically.

## Customization

### Installing Other Applications

To install other Windows applications:

1. Modify the `install_wechat.sh` script in the `scripts` directory to install your desired application instead of WeChat.
2. Update the Dockerfile to copy your application installer into the container.
3. Rebuild the Docker image.

### Changing VNC Password

By default, the VNC server runs without a password. To add a password:

1. Modify the `entrypoint.sh` script to use a password with x11vnc:
   
   ```bash
   x11vnc -display :99 -forever -passwd your_password &
   ```

2. Rebuild the Docker image.

## Troubleshooting

1. If you encounter issues with Wine, check the container logs:

   ```bash
   docker logs <container_id>
   ```

2. To enter the container for debugging:

   ```bash
   docker exec -it <container_id> /bin/bash
   ```

3. If the application doesn't display correctly, ensure you've added the necessary Windows fonts.

## Security Considerations

- This setup exposes a VNC server to the network. In a production environment, always use this behind a secure reverse proxy with HTTPS.
- Consider implementing additional authentication mechanisms for the noVNC interface.

## Contributing

Contributions to improve this project are welcome. Please feel free to submit issues or pull requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- The Wine project (https://www.winehq.org/)
- noVNC (https://novnc.com/)

For more information on using Docker, Wine, or noVNC, please refer to their respective documentation.
