FROM alpine:latest

RUN apk add --no-cache jq curl dpkg openssh-client

RUN DOWNLOAD_LINK=$(curl -X GET https://api.github.com/repos/gohugoio/hugo/releases/latest | \
    jq -r '.assets[].browser_download_url' | \
    grep -v 'extended' | \
    grep 'Linux-64bit.deb$') && \
    curl -L "$DOWNLOAD_LINK" --output hugo.deb && \
    dpkg --force-architecture -i hugo.deb && \
    rm hugo.deb

ENTRYPOINT [ "sh" ]
