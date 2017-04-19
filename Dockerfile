FROM golang:1.8.1-alpine

ENV tag

RUN apk update; apk upgrade && apk add --no-cache bash git glide && \
    cd /go/src && go get -u github.com/jteeuwen/go-bindata/... && \
    mkdir -p github.com/containous && \
    cd github.com/containous && git clone https://github.com/hmrc/traefik && \
    cd traefik && git checkout ${tag} && \
    glide install -v && \
    go generate && go install -v -ldflags "-s -w"
