# ---- Build Stage ----
FROM alpine:3.21 AS builder

# 安装编译 redis-cell 所需的依赖
RUN apk add --no-cache \
    build-base \
    git \
    rust \
    cargo

# 设置工作目录
WORKDIR /usr/src

# 克隆 redis-cell 仓库
RUN git clone https://github.com/brandur/redis-cell.git

# 编译 redis-cell
WORKDIR /usr/src/redis-cell
RUN cargo build --release

# ---- Final Stage ----
FROM redis:6-alpine

# 临时切换到 root 用户以创建目录和复制文件
USER root

# 创建 Redis 模块目录
RUN mkdir -p /usr/local/lib/redis/modules

# 从构建阶段复制编译好的模块库
COPY --from=builder /usr/src/redis-cell/target/release/libredis_cell.so /usr/local/lib/redis/modules/

# 确保模块文件归 redis 用户所有 (可选，但推荐)
RUN chown redis:redis /usr/local/lib/redis/modules/libredis_cell.so

# 切换回 redis 用户 (官方镜像的默认用户)
USER redis

# 修改 CMD 以加载 redis-cell 模块
# 基础镜像的 CMD 是 ["redis-server"]
# 我们在其后添加 --loadmodule 参数
CMD ["redis-server", "--loadmodule", "/usr/local/lib/redis/modules/libredis_cell.so"]