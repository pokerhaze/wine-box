#!/bin/sh
set -euxo pipefail

# Install wrapper script for box86 & box64
cat << EOF > /usr/local/bin/wine
#!/bin/sh
WINEPREFIX=\$HOME/.wine WINEARCH=win32 box86 /opt/wine/bin/wine \$@
EOF
cat << EOF > /usr/local/bin/wine64
#!/bin/sh
WINEPREFIX=\$HOME/.wine64 WINEARCH=win64 box64 /opt/wine/bin/wine64 \$@
EOF
cat << EOF > /usr/local/bin/wineserver
#!/bin/sh
WINEPREFIX=\$HOME/.wine64 WINEARCH=win64 box64 /opt/wine/bin/wineserver \$@
EOF
ln -sf /opt/wine/bin/wineboot /usr/local/bin/wineboot
ln -sf /opt/wine/bin/winecfg /usr/local/bin/winecfg
chmod +x /usr/local/bin/wine /usr/local/bin/wine64 /usr/local/bin/wineboot /usr/local/bin/winecfg /usr/local/bin/wineserver
