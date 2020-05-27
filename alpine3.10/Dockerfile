FROM alpine:3.10

# make user
ENV USERID 1000
RUN addgroup jobberuser && \
    adduser -S -u "${USERID}" -G jobberuser jobberuser && \
    mkdir -p "/var/jobber/${USERID}" && \
    chown -R jobberuser:jobberuser "/var/jobber/${USERID}"

# install jobber
ENV JOBBER_VERSION 1.4.3
ENV JOBBER_SHA256 c317006fdc96f84fe0a97c334d585bee51ec879f49ac33fc04d862e62f08256f
RUN wget -O /tmp/jobber.apk "https://github.com/dshearer/jobber/releases/download/v${JOBBER_VERSION}/jobber-${JOBBER_VERSION}-r0.apk" && \
    echo "${JOBBER_SHA256} */tmp/jobber.apk" | sha256sum -c && \
# --no-scripts is needed b/c the post-install scripts don't work in Docker
    apk add --no-network --no-scripts --allow-untrusted /tmp/jobber.apk && \
    rm /tmp/jobber.apk

# add jobfile
COPY --chown=jobberuser:jobberuser jobfile /home/jobberuser/.jobber
RUN chmod 0600 /home/jobberuser/.jobber

USER jobberuser
CMD ["/usr/libexec/jobberrunner", "-u", "/var/jobber/1000/cmd.sock", "/home/jobberuser/.jobber"]
