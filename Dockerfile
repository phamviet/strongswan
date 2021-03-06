FROM alpine

ENV VPN_NETWORK_IPV4="192.168.99.0/24"
ENV VPN_NETWORK_IPV6="fd9d:bc11:4020::/48"
ENV IKE_CIPHERS="aes128gcm16-prfsha512-ecp256!"
ENV ESP_CIPHERS="aes128gcm16-ecp256!"
ENV LAN_NETWORK="192.168.0.0/16"
ENV VPN_DNS=8.8.8.8,8.8.4.4

RUN apk add --no-cache iptables openssl strongswan util-linux \
    && ln -sf /etc/ipsec.d/ipsec.conf /etc/ipsec.conf \
    && ln -sf /etc/ipsec.d/ipsec.secrets /etc/ipsec.secrets

COPY initial-setup.sh /initial-setup.sh
COPY docker-entrypoint.sh /docker-entrypoint.sh

VOLUME /etc/ipsec.d /etc/strongswan.d

EXPOSE 500/udp 4500/udp

ENTRYPOINT ["/docker-entrypoint.sh"]
