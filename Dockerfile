FROM golang:1.16-alpine AS builder

WORKDIR /app
ADD . /app

RUN go get google.golang.org/protobuf/cmd/protoc-gen-go
RUN go build google.golang.org/protobuf/cmd/protoc-gen-go

RUN go get google.golang.org/grpc/cmd/protoc-gen-go-grpc
RUN go build google.golang.org/grpc/cmd/protoc-gen-go-grpc

RUN go get \
    github.com/bufbuild/buf/cmd/buf \
    github.com/bufbuild/buf/cmd/protoc-gen-buf-breaking \
    github.com/bufbuild/buf/cmd/protoc-gen-buf-lint
RUN go build \
    github.com/bufbuild/buf/cmd/buf \
    github.com/bufbuild/buf/cmd/protoc-gen-buf-breaking \
    github.com/bufbuild/buf/cmd/protoc-gen-buf-lint

CMD [ "buf", "help" ]
