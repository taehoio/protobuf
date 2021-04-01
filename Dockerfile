FROM golang:1.16 AS golang

WORKDIR /app
ADD . /app

RUN go get google.golang.org/protobuf/cmd/protoc-gen-go
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go

RUN go get google.golang.org/grpc/cmd/protoc-gen-go-grpc
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc

RUN go get github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway
RUN go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway

RUN go get github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2
RUN go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2

RUN go get \
    github.com/bufbuild/buf/cmd/buf \
    github.com/bufbuild/buf/cmd/protoc-gen-buf-breaking \
    github.com/bufbuild/buf/cmd/protoc-gen-buf-lint
RUN go install \
    github.com/bufbuild/buf/cmd/buf \
    github.com/bufbuild/buf/cmd/protoc-gen-buf-breaking \
    github.com/bufbuild/buf/cmd/protoc-gen-buf-lint


FROM gcr.io/distroless/base

WORKDIR /app
COPY --from=golang /go/bin /app

ENV PATH="${PATH}:/app"

CMD [ "buf", "help" ]
