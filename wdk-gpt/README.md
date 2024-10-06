Here’s a **README** for using the Dockerfile and setting up the environment.

---

# toychat - Wine-based Docker Environment with WeChat

This project provides a Docker container for running Windows applications, such as WeChat, in a headless environment with support for ARM64 architecture. It uses Wine, Xvfb, and noVNC to allow access to the container's GUI through a web browser or VNC client.

## Features

- **Multi-platform support (ARM64/amd64)**: The image supports Wine running on ARM64 (using `box86` and `box64`).
- **Wine and winetricks**: Allows running Windows applications like WeChat inside the container.
- **noVNC and VNC**: Access the container’s GUI (including WeChat) via a web browser or VNC client.
- **UTF-8 Locale (Chinese)**: Locale settings configured to support Chinese fonts.

## Prerequisites

- Docker installed on your machine or VPS.
- (Optional) A VNC client for remote desktop access, if you prefer VNC over noVNC.

## Getting Started

### 1. Clone the Repository

Clone this repository to your local machine or VPS where Docker is installed:

```bash
git clone <repository-url>
cd <repository-folder>
```

### 2. Build the Docker Image

To build the Docker image, run the following command from the project root where the Dockerfile is located:

```bash
docker build -t toychat .
```

This command will create a Docker image named `toychat`.

### 3. Run the Docker Container

To run the container, execute the following command:

```bash
docker run -d -p 5900:5900 -p 6080:6080 --name toychat toychat
```

This command will:

- Start the container in detached mode (`-d`).
- Map port **5900** for VNC access.
- Map port **6080** for noVNC (web-based VNC client) access.
- Name the running container `toychat`.

### 4. Access the Container

#### Option 1: Via VNC Client

You can connect to the container using any VNC client (e.g., RealVNC, TigerVNC, etc.):

1. Open your VNC client.
2. Enter the IP address of your VPS and port **5900**.
3. The password is `password`.

#### Option 2: Via noVNC (Web Browser)

You can also access the container's GUI via a web browser using noVNC:

1. Open your browser and go to:
   ```
   http://<your_vps_ip>:6080
   ```
2. Enter the VNC password (`password`).
3. You will now have access to the virtual desktop in your browser.

### 5. Running WeChat and Other Applications

WeChat will automatically start when the container is launched. If you want to launch other Windows applications:

1. Open a terminal inside the container (accessible from VNC or noVNC).
2. Run any Windows application via Wine, for example:

```bash
wine notepad
```

This will launch the Windows version of Notepad in the container.

### 6. Stopping and Restarting the Container

To stop the container:

```bash
docker stop toychat
```

To start it again:

```bash
docker start toychat
```

To remove the container when it is no longer needed:

```bash
docker rm -f toychat
```

## Testing Wine Installation

To verify that Wine is installed and working correctly inside the container:

1. Connect to the container using either VNC or noVNC.
2. Open a terminal inside the container.
3. Run the following command to launch the Windows version of Notepad:

```bash
wine notepad
```

If Wine is functioning correctly, you will see the Notepad application appear.

## Modifications

- **Changing the VNC password**: The password for VNC is set in the `start.sh` script. Modify the line in the script to change it:

```bash
echo "your_new_password" | vncpasswd -f > /root/.vnc/passwd
```

- **Adding more applications**: You can install additional Windows applications by downloading their `.exe` files and running them via Wine, e.g.:

```bash
wine some-windows-app.exe
```

## Troubleshooting

- **Container not starting?** Make sure you have built the Docker image with the `docker build` command and that it completed successfully.
- **No GUI when accessing via VNC or noVNC?** Ensure the Xvfb virtual display is running and that the container’s ports (`5900` and `6080`) are correctly mapped.
- **WeChat not launching?** Make sure the WeChat installation completed properly inside the container by checking the log output or retrying the installation.

## Credits

- **Wine** for allowing Windows applications to run on Linux.
- **noVNC** for providing web-based VNC access.
- **Xvfb** for running headless X server sessions.

## License

This project is licensed under the MIT License.

---

### Instructions to Edit:
- Replace `<repository-url>` with the actual repository URL if applicable.

