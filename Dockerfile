# ---- Build Stage ----
FROM alpine:3.21 AS builder

RUN apk add --no-cache \
    build-base \
    git \
    rust \
    cargo

WORKDIR /usr/src

RUN git clone https://github.com/brandur/redis-cell.git

WORKDIR /usr/src/redis-cell
RUN cargo build --release

# ---- Final Stage ----
FROM redis:6-alpine

# Switch to root to copy files
USER root

# Install runtime dependency for redis-cell module
RUN apk add --no-cache libgcc

# Create module directory
RUN mkdir -p /usr/local/lib/redis/modules

# Copy compiled module from builder stage
COPY --from=builder /usr/src/redis-cell/target/release/libredis_cell.so /usr/local/lib/redis/modules/

# Ensure redis user owns the module file
RUN chown redis:redis /usr/local/lib/redis/modules/libredis_cell.so

# Switch back to redis user
USER redis

# Load redis-cell module on startup
CMD ["redis-server", "--loadmodule", "/usr/local/lib/redis/modules/libredis_cell.so"]