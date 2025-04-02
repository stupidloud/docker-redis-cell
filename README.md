# Redis with Redis Cell Module

[![Docker Build Status](https://github.com/stupidloud/docker-redis-cell/actions/workflows/docker-build.yml/badge.svg)](https://github.com/stupidloud/docker-redis-cell/actions/workflows/docker-build.yml)

This repository contains a Dockerfile to build a Redis image (based on `redis:6-alpine`) that includes the [Redis Cell](https://github.com/brandur/redis-cell) module. The image is automatically built and pushed to GitHub Container Registry (GHCR) via GitHub Actions.

[阅读中文版 (Read in Chinese)](README.zh-CN.md)

## Usage

You can pull the pre-built image from GHCR:

```bash
docker pull ghcr.io/stupidloud/docker-redis-cell/redis-with-cell:latest
```

Or pull a specific version tag (e.g., `v1.0.0`):

```bash
docker pull ghcr.io/stupidloud/docker-redis-cell/redis-with-cell:v1.0.0
```

Then run the container:

```bash
docker run -d -p 6379:6379 --name my-redis-cell ghcr.io/stupidloud/docker-redis-cell/redis-with-cell:latest
```

The Redis Cell module (`libredis_cell.so`) is loaded automatically via the `--loadmodule` argument in the container's command.

## Building Locally

```bash
docker build -t redis-with-cell .
```

## GitHub Actions

The workflow in `.github/workflows/docker-build.yml` handles the automated build and push process to GHCR upon pushes to the `main` branch or version tags (`v*.*.*`).