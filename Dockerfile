FROM golang:alpine AS build

RUN apk add --no-cache ca-certificates=20241121-r1

WORKDIR /build
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o notely

ENTRYPOINT ["/build/notely"]
