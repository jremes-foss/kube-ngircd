FROM alpine:3.18
WORKDIR /home/ircd-admin
COPY motd /etc/ngircd/ngircd.motd
COPY ngircd.conf /etc/ngircd/ngircd.conf
RUN apk --no-cache add ngircd
RUN rm -rf /var/cache/apk/*
RUN adduser ircd-admin -u 1000 -S ircd-admin && \
    chown -R ircd-admin /home/ircd-admin/
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
USER 1000
CMD ["/entrypoint.sh"]
