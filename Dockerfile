FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    xfce4 xfce4-terminal \
    tightvncserver \
    novnc websockify \
    dbus-x11 \
    x11-xserver-utils \
    firefox-esr \
    sudo \
    curl wget nano \
    ca-certificates \
    python3 \
    net-tools \
    && apt clean

# Create user
RUN useradd -m -s /bin/bash admin \
    && echo "admin:admin123" | chpasswd \
    && adduser admin sudo

# VNC config
RUN mkdir -p /home/admin/.vnc \
 && echo "admin123" | vncpasswd -f > /home/admin/.vnc/passwd \
 && chmod 600 /home/admin/.vnc/passwd \
 && echo '#!/bin/sh\nunset SESSION_MANAGER\nunset DBUS_SESSION_BUS_ADDRESS\nexec startxfce4 &' > /home/admin/.vnc/xstartup \
 && chmod +x /home/admin/.vnc/xstartup \
 && chown -R admin:admin /home/admin/.vnc

# noVNC web
RUN ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080
CMD ["/start.sh"]
