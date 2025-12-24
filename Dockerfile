# Multi-stage build for bootdev CLI
# Stage 1: Build
FROM golang:1.22-alpine AS builder

WORKDIR /build

# Install build dependencies
RUN apk add --no-cache \
    git \
    ca-certificates

# Clone the bootdev repository
RUN git clone https://github.com/bootdotdev/bootdev.git .

# Build the bootdev CLI
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o bootdev .

FROM alpine:3.19

# Add labels for container metadata
LABEL org.opencontainers.image.source="https://github.com/bootdotdev/bootdev"
LABEL org.opencontainers.image.description="Container image for bootdev CLI"
LABEL org.opencontainers.image.licenses="MIT"

# Install runtime dependencies and development tools
RUN apk add --no-cache \
    ca-certificates \
    bash \
    git \
    curl \
    wget \
    make \
    build-base \
    python3

# Set working directory
WORKDIR /root

# Copy bootdev binary from builder
COPY --from=builder /build/bootdev /usr/local/bin/bootdev

# Ensure the binary is executable
RUN chmod +x /usr/local/bin/bootdev

# Create a non-root user with sudo access (best practice)
RUN apk add --no-cache sudo && \
    addgroup -S bootdev && \
    adduser -S bootdev -G bootdev && \
    echo "bootdev ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/bootdev && \
    chmod 0440 /etc/sudoers.d/bootdev

# Set the bootdev user
USER bootdev

# Use sh as the default shell (allows command execution)
CMD ["/bin/sh"]
