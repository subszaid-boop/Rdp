FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

# Basic system update
RUN apt update && apt upgrade -y

# Install desktop + RDP
RUN apt install -y \
    xfce4 \
    xfce4-goodies \
    xrdp \
    sudo \
    dbus-x11 \
    wget \
    curl \
    git \
    firefox-esr \
    xterm \
    nano \
    ca-certificates

# Create user (VPS user)
RUN useradd -m -s /bin/bash admin \
    && echo "admin:admin123" | chpasswd \
    && adduser admin sudo

# XFCE session for RDP
RUN echo "xfce4-session" > /home/admin/.xsession \
    && chown admin:admin /home/admin/.xsession

# XRDP Fix
RUN sed -i 's/port=3389/port=3389/g' /etc/xrdp/xrdp.ini \
    && sed -i 's/max_bpp=32/max_bpp=24/g' /etc/xrdp/xrdp.ini

# Allow XRDP to use SSL
RUN adduser xrdp ssl-cert

# Expose RDP port
EXPOSE 3389

# Start services
CMD service dbus start && service xrdp start && tail -f /dev/null
