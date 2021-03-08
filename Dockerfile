FROM golang:1.16-alpine AS builder

WORKDIR /app
ADD . /app

RUN go get google.golang.org/protobuf/cmd/protoc-gen-go@v1.25.0
RUN go build google.golang.org/protobuf/cmd/protoc-gen-go

RUN go get google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1.0
RUN go build google.golang.org/grpc/cmd/protoc-gen-go-grpc

CMD [ "protoc-gen-go-grpc", "--help" ]
