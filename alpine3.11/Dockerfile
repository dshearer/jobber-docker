FROM alpine:3.11

# make user
ENV USERID 1000
RUN addgroup jobberuser && \
    adduser -S -u "${USERID}" -G jobberuser jobberuser && \
    mkdir -p "/var/jobber/${USERID}" && \
    chown -R jobberuser:jobberuser "/var/jobber/${USERID}"

# install jobber
ENV JOBBER_VERSION 1.4.4
ENV JOBBER_SHA256 ec09b2efafff69c91fba2124bf28607209e1c9b50ed834ff444a9d40798aa8d3
RUN wget -O /tmp/jobber.apk "https://github.com/dshearer/jobber/releases/download/v${JOBBER_VERSION}/jobber-${JOBBER_VERSION}-r0.apk" && \
    echo -n "Actual checksum: " && sha256sum /tmp/jobber.apk && \
    echo "${JOBBER_SHA256} */tmp/jobber.apk" | sha256sum -c && \
# --no-scripts is needed b/c the post-install scripts don't work in Docker
    apk add --no-network --no-scripts --allow-untrusted /tmp/jobber.apk && \
    rm /tmp/jobber.apk

# add jobfile
COPY --chown=jobberuser:jobberuser jobfile /home/jobberuser/.jobber
RUN chmod 0600 /home/jobberuser/.jobber

USER jobberuser
CMD ["/usr/libexec/jobberrunner", "-u", "/var/jobber/1000/cmd.sock", "/home/jobberuser/.jobber"]
