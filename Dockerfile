FROM alpine:3.18
WORKDIR /home/ircd-admin
COPY motd /etc/ngircd/ngircd.motd
COPY ngircd.conf /etc/ngircd/ngircd.conf
RUN apk --no-cache add ngircd
RUN rm -rf /var/cache/apk/*
RUN adduser ngircd-admin -u 1000 -S ngircd-admin && \
    chown -R ngircd-admin /home/ngircd-admin/
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
USER 1000
CMD ["/entrypoint.sh"]
