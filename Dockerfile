FROM alpine:3.12

RUN apk update && apk add curl \
    openssl \
    easy-rsa \
    openvpn \
    iptables \
    bash && \
    rm -rf /tmp/* \
        /var/tmp/* \
        /var/cache/apk/*

RUN mkdir -p /dev/net && \
    mknod /dev/net/tun c 10 200
