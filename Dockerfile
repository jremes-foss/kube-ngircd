FROM alpine:3.18
WORKDIR /home/ircd-admin
COPY motd /etc/ngircd/ngircd.motd
COPY ngircd.conf /etc/ngircd/ngircd.conf
RUN apk --no-cache add ngircd
RUN rm -rf /var/cache/apk/*
