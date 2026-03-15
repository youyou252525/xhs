# 通用Go语言版本，如果你是Python项目换我之前给的Python版Dockerfile就行
FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o xiaohongshu-mcp main.go

FROM alpine:latest
RUN apk add --no-cache ca-certificates tzdata
WORKDIR /app
COPY --from=builder /app/xiaohongshu-mcp .
EXPOSE 18060
CMD ["./xiaohongshu-mcp"]
