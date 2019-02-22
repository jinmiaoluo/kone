#build stage
FROM golang:alpine AS builder
WORKDIR /go
RUN apk add --no-cache git
RUN go get -u github.com/xjdrew/kone

#final stage
FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=builder /go/bin/kone /usr/local/bin/kone
COPY --from=builder /go/src/github.com/xjdrew/kone/example.ini /etc/example.ini
CMD ["/usr/local/bin/kone", "-config", "/etc/example.ini"]