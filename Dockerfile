FROM golang:1.17-alpine3.15 AS golang

WORKDIR /app
ADD . /app

RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.27.1
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2.0
RUN go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@v2.7.2
RUN go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@v2.7.2
RUN	go install \
    github.com/bufbuild/buf/cmd/buf@v1.0.0-rc10 \
    github.com/bufbuild/buf/cmd/protoc-gen-buf-breaking@v1.0.0-rc10 \
    github.com/bufbuild/buf/cmd/protoc-gen-buf-lint@v1.0.0-rc10


FROM alpine:3.15

WORKDIR /app
COPY --from=golang /go/bin /app

ENV PATH="${PATH}:/app"

CMD [ "buf", "help" ]
