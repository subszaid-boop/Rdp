FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y

RUN apt install -y \
    xfce4 xfce4-goodies \
    xrdp \
    dbus-x11 \
    sudo \
    openssh-server \
    curl wget nano \
    firefox-esr \
    ca-certificates

RUN mkdir /var/run/sshd

RUN useradd -m -s /bin/bash admin \
    && echo "admin:admin123" | chpasswd \
    && adduser admin sudo

RUN echo "xfce4-session" > /home/admin/.xsession \
    && chown admin:admin /home/admin/.xsession

RUN adduser xrdp ssl-cert

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 3389
EXPOSE 22

CMD ["/start.sh"]
