FROM golang:1.13.3-alpine as builder
RUN apk add --no-cache git
ENV GO111MODULE on
ENV GOPROXY https://proxy.golang.org

WORKDIR /go/src/github.com/MattHodge/tilt-demo/apps/intake/
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
RUN mkdir /output \
    && CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -a -installsuffix cgo -ldflags '-s -w' -o /output/intake

FROM alpine:3.9

RUN apk update \
  && apk upgrade \
  && apk add --no-cache \
  ca-certificates \
  && update-ca-certificates 2>/dev/null || true

COPY scripts/start.sh /bin/start.sh
COPY scripts/restart.sh /bin/restart.sh

COPY --from=builder /output/intake /bin/intake




