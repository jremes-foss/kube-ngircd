FROM alpine:3.18
WORKDIR /home/ircd-admin
COPY motd /etc/ngircd/ngircd.motd
