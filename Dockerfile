FROM golang:1.22-alpine AS builder
WORKDIR /app
# 直接复制主文件构建，不需要go mod
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -o xiaohongshu-mcp main.go

FROM alpine:latest
RUN apk add --no-cache ca-certificates tzdata
WORKDIR /app
COPY --from=builder /app/xiaohongshu-mcp .
EXPOSE 18060
CMD ["./xiaohongshu-mcp"]
