FROM alpine:3.7
MAINTAINER C. Dylan Shearer <dylan@nekonya.info>

WORKDIR /jobber
COPY jobber.apk /jobber/
# --no-scripts is needed b/c the post-install scripts don't work in Docker
RUN apk add --no-scripts --allow-untrusted /jobber/jobber.apk

ENV USERID 100
RUN addgroup jobberuser && \
    adduser -S -u "${USERID}" -G jobberuser jobberuser && \
    mkdir -p "/var/jobber/${USERID}" && \
    chown -R jobberuser:jobberuser "/var/jobber/${USERID}"

COPY jobfile /home/jobberuser/.jobber
RUN chown jobberuser:jobberuser /home/jobberuser/.jobber && \
    chmod 0600 /home/jobberuser/.jobber

USER jobberuser
ENTRYPOINT ["/usr/libexec/jobberrunner"]
CMD ["/home/jobberuser/.jobber"]
