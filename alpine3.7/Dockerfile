FROM golang:1.9-alpine
MAINTAINER C. Dylan Shearer <dylan@nekonya.info>

ENV JOBBER_VER v1.3.3-pr.2
ENV SRC_HASH e461f63d59ed63ce6186150e850891c83fc573ab0a7a7fd3e799e610a5cbd07b

RUN apk update && \
    apk upgrade && \
    apk add --update make rsync grep ca-certificates openssl wget

WORKDIR /go_wkspc/src/github.com/dshearer
RUN wget "https://api.github.com/repos/dshearer/jobber/tarball/${JOBBER_VER}" -O jobber.tar.gz && \
    echo "${SRC_HASH}  jobber.tar.gz" | sha256sum -cw && \
    tar xzf *.tar.gz && rm *.tar.gz && mv dshearer-* jobber && \
    cd jobber && \
    make check && \
    make install DESTDIR=/jobber-dist/

FROM alpine:3.7

RUN mkdir /jobber
COPY --from=0 /jobber-dist/usr/local/libexec/jobberrunner /jobber/jobberrunner
COPY --from=0 /jobber-dist/usr/local/bin/jobber /jobber/jobber
ENV PATH /jobber:${PATH}

ENV USERID 100
RUN addgroup jobberuser && \
    adduser -S -u "${USERID}" -G jobberuser jobberuser && \
    mkdir -p "/var/jobber/${USERID}" && \
    chown -R jobberuser:jobberuser "/var/jobber/${USERID}"

COPY jobfile /home/jobberuser/.jobber
RUN chown jobberuser:jobberuser /home/jobberuser/.jobber && \
    chmod 0600 /home/jobberuser/.jobber
USER jobberuser
ENTRYPOINT ["jobberrunner"]
CMD ["/home/jobberuser/.jobber"]
