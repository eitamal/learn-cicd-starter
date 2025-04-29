FROM golang:alpine AS build

WORKDIR /build
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o notely

FROM scratch
COPY --from=build /build/notely /notely
# RUN apk add ca-certificates
ENTRYPOINT ["/notely"]
