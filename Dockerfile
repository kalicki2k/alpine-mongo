FROM kalicki2k/alpine-base:3.7

MAINTAINER Sebastian Kalicki (https://github.com/kalicki2k)

COPY Dockerfiles/. /

RUN apk update && apk upgrade && \
    apk add mongodb openrc && \
    chmod +x /run.sh && \
    rm -rf /var/cache/apk/*

EXPOSE 27017 28017

ENTRYPOINT ["/run.sh"]
