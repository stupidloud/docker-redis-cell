# 包含 Redis Cell 模块的 Redis 镜像

[![Docker 构建状态](https://github.com/stupidloud/docker-redis-cell/actions/workflows/docker-build.yml/badge.svg)](https://github.com/stupidloud/docker-redis-cell/actions/workflows/docker-build.yml)

这个仓库包含一个 Dockerfile，用于构建一个包含 [Redis Cell](https://github.com/brandur/redis-cell) 模块的 Redis 镜像（基于 `redis:6-alpine`）。该镜像通过 GitHub Actions 自动构建并推送到 GitHub Container Registry (GHCR)。

[Read in English](README.md)

## 如何使用

你可以从 GHCR 拉取预构建的镜像：

```bash
docker pull ghcr.io/stupidloud/docker-redis-cell/redis-with-cell:latest
```

或者拉取特定版本标签（例如 `v1.0.0`）：

```bash
docker pull ghcr.io/stupidloud/docker-redis-cell/redis-with-cell:v1.0.0
```

然后运行容器：

```bash
docker run -d -p 6379:6379 --name my-redis-cell ghcr.io/stupidloud/docker-redis-cell/redis-with-cell:latest
```

Redis Cell 模块 (`libredis_cell.so`) 会通过容器命令中的 `--loadmodule` 参数自动加载。

## 本地构建

```bash
docker build -t redis-with-cell .
```

## GitHub Actions

`.github/workflows/docker-build.yml` 中的工作流负责在代码推送到 `main` 分支或推送版本标签 (`v*.*.*`) 时，自动构建镜像并将其推送到 GHCR。