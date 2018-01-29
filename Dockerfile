FROM alpine:3.7
MAINTAINER C. Dylan Shearer <dylan@nekonya.info>

RUN apk update && \
    apk upgrade && \
    apk add --update --no-cache --virtual .build-deps \
        'go@community>=1.8' \
        make \
        git \
        rsync \
        musl-dev \
        grep
WORKDIR /go_wkspc/src/github.com/dshearer
RUN git clone https://github.com/dshearer/jobber.git && \
    cd jobber && \
    git checkout v1.3.0 && \
    make check && \
    make install DESTDIR=/ && \
    mkdir -p /var/jobber/0 && \
    mkdir -p /jobber
RUN apk del .build-deps && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/* && \
    rm -rf /var/log/*

CMD ["/usr/local/libexec/jobberrunner", "/jobber/.jobber"]
