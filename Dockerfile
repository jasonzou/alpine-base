FROM alpine:latest
MAINTAINER Jason Zou <jason.zou@gmail.com>

ENV S6OVERLAY_VERSION=v2.2.0.3 \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=1 \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    TERM=xterm

RUN apk update && \
    apk upgrade && \
    apk add bash bind-tools ca-certificates curl jq tar && \
    apk --update add openssh rsync && \
    sed -ri 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config && \
    curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6OVERLAY_VERSION}/s6-overlay-amd64.tar.gz | tar xz -C / && \
    echo "root:LibraryBlahBlah" | chpasswd && \
    apk del bind-tools ca-certificates jq && \
    rm -rf /var/cache/apk/* /src

COPY root /

# EntryPoint
ENTRYPOINT ["/init"]

EXPOSE 22

CMD []
