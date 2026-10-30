# OpenSSH

[![CI Pipeline](https://img.shields.io/github/actions/workflow/status/snowdreamtech/openssh/ci.yml?branch=main&label=CI%20Pipeline)](https://github.com/snowdreamtech/openssh/actions/workflows/ci.yml)
[![CD Pipeline](https://img.shields.io/github/actions/workflow/status/snowdreamtech/openssh/cd.yml?branch=main&label=CD%20Pipeline)](https://github.com/snowdreamtech/openssh/actions/workflows/cd.yml)
[![CodeQL](https://img.shields.io/github/actions/workflow/status/snowdreamtech/openssh/codeql.yml?branch=main&label=CodeQL&logo=github)](https://github.com/snowdreamtech/openssh/actions/workflows/codeql.yml)
[![Security Audit](https://img.shields.io/badge/Security-Zizmor%20%7C%20Trivy%20%7C%20Gitleaks-brightgreen)](https://github.com/snowdreamtech/openssh/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/license/MIT)
![Docker Image Version](https://img.shields.io/docker/v/snowdreamtech/openssh)
![Docker Image Size](https://img.shields.io/docker/image-size/snowdreamtech/openssh/latest)
![Docker Pulls](https://img.shields.io/docker/pulls/snowdreamtech/openssh)
![Docker Stars](https://img.shields.io/docker/stars/snowdreamtech/openssh)

[English](README.md) | [简体中文](README_zh-CN.md)

OpenSSH server Docker images providing standardized container foundations with flexible entrypoint systems, multi-architecture support, and consistent configuration patterns across Alpine, Debian, and Rocky Linux distributions.

## Overview

These OpenSSH Docker images serve as a secure, flexible, and ready-to-use OpenSSH server container. They provide:

- **Standardized Dockerfiles** with OCI annotations and best practices
- **Pre-configured OpenSSH Server** with sensible defaults and multi-architecture support
- **Automatic host key generation**
- **Flexible entrypoint system** supporting custom initialization scripts
- **Consistent environment variable configuration** across all variants
- **Multi-architecture support** for diverse hardware platforms
- **User/group management** with PUID/PGID support for permission handling
- **Three distribution variants**: Alpine (lightweight), Debian (default/widely-compatible), Rocky (enterprise)

## Quick Start

```bash
# Pull and run the default Debian variant
docker pull snowdreamtech/openssh:debian
docker run -d --name=openssh -p 22:22 -e TZ=Asia/Shanghai snowdreamtech/openssh:debian

# Or use docker compose
docker compose up -d
```

## Usage

### 1. Passwordless Login (Recommended)

Mount your public key to `/root/.ssh/authorized_keys` for key-based authentication:

```bash
docker run -d \
  --name=openssh \
  -e TZ=Asia/Shanghai \
  -p 22:22 \
  -v ~/.ssh/id_rsa.pub:/root/.ssh/authorized_keys:ro \
  --restart unless-stopped \
  snowdreamtech/openssh:latest
```

Login:

```bash
ssh root@localhost -p 22
```

### 2. Password Login

When the container starts without `SSH_ROOT_CRED`, it automatically generates a random password and prints it in the logs:

```bash
docker logs openssh
```

To set a fixed password:

```bash
docker run -d \
  --name=openssh \
  -e SSH_ROOT_CRED=your_secure_password \
  -p 22:22 \
  --restart unless-stopped \
  snowdreamtech/openssh:latest
```

Or change it in a running container:

```bash
docker exec -it openssh sh -c "echo 'root:your_secure_password' | chpasswd"
```

### 3. Custom Configuration

If you want to use your own `sshd_config` or provide host keys to prevent SSH warnings when the container is recreated:

```bash
docker run -d \
  --name=openssh \
  -p 22:22 \
  -v /my/custom/sshd_config:/etc/ssh/sshd_config:ro \
  -v /my/host/keys:/etc/ssh/ \
  snowdreamtech/openssh:latest
```

## Distribution Variants

### Debian (Default)

The recommended variant for most use cases, providing wide compatibility and extensive package availability.

```bash
docker run -d \
  --name=openssh \
  -e TZ=Asia/Shanghai \
  -p 22:22 \
  --restart unless-stopped \
  snowdreamtech/openssh:debian
```

**Supported Architectures**: amd64, arm32v7, arm64, ppc64le, riscv64, s390x

**Base Image**: `snowdreamtech/debian:13.6.0`

### Alpine

Lightweight variant optimized for minimal image size and fast startup times.

```bash
docker run -d \
  --name=openssh \
  -e TZ=Asia/Shanghai \
  -p 22:22 \
  --restart unless-stopped \
  snowdreamtech/openssh:alpine
```

**Supported Architectures**: 386, amd64, arm/v6, arm/v7, arm64, ppc64le, riscv64, s390x

**Base Image**: `snowdreamtech/alpine:3.24.1`

### Rocky

Enterprise-focused variant based on Rocky Linux, ideal for production environments requiring RHEL compatibility.

```bash
docker run -d \
  --name=openssh \
  -e TZ=Asia/Shanghai \
  -p 22:22 \
  --restart unless-stopped \
  snowdreamtech/openssh:rocky
```

**Supported Architectures**: amd64, arm64, ppc64le, s390x

**Base Image**: `snowdreamtech/rocky:10.2.0`

## Build Instructions

### Single Architecture Build

```bash
# Build Debian variant
docker build -t snowdreamtech/openssh:debian ./docker/debian/

# Build Alpine variant
docker build -t snowdreamtech/openssh:alpine ./docker/alpine/

# Build Rocky variant
docker build -t snowdreamtech/openssh:rocky ./docker/rocky/
```

### Multi-Architecture Build

Build images for multiple architectures using `docker buildx`:

```bash
# Create and use a buildx builder
docker buildx create --use --name build --node build --driver-opt network=host

# Build Debian for multiple architectures
docker buildx build \
  --platform=linux/amd64,linux/arm/v7,linux/arm64,linux/ppc64le,linux/riscv64,linux/s390x \
  -t snowdreamtech/openssh:debian \
  ./docker/debian/ \
  --push

# Build Alpine for multiple architectures
docker buildx build \
  --platform=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/riscv64,linux/s390x \
  -t snowdreamtech/openssh:alpine \
  ./docker/alpine/ \
  --push

# Build Rocky for multiple architectures
docker buildx build \
  --platform=linux/amd64,linux/arm64,linux/ppc64le,linux/s390x \
  -t snowdreamtech/openssh:rocky \
  ./docker/rocky/ \
  --push
```

## Environment Variables

All variants support the following environment variables for runtime configuration:

| Variable | Default | Description |
|----------|---------|-------------|
| `SSH_ROOT_CRED` | - | Root password (generated randomly if not set) |
| `KEEPALIVE` | `0` | Keep container running (1=enabled, 0=disabled) |
| `CAP_NET_BIND_SERVICE` | `0` | Enable binding to privileged ports (<1024) |
| `LANG` | `C.UTF-8` | Locale setting for UTF-8 character support |
| `UMASK` | `022` | Default file creation mask |
| `DEBUG` | `false` | Enable debug output in entrypoint scripts |
| `PASSWORDLESS_SUDO` | `false` | Enable passwordless sudo for non-root users (true/false) |
| `PGID` | `0` | Primary group ID for custom user creation |
| `PUID` | `0` | User ID for custom user creation |
| `USER` | `root` | Username for custom user creation |
| `WORKDIR` | `/root` | Working directory path |
| `TZ` | - | Timezone (e.g., `Asia/Shanghai`, `America/New_York`) |
| `OPENSSH_VERSION` | varies | OpenSSH version installed |

**Debian-specific**:

| Variable | Default | Description |
|----------|---------|-------------|
| `DEBIAN_FRONTEND` | `noninteractive` | Debian package installation mode |

## Docker Compose Examples

```yaml
services:
  openssh:
    image: snowdreamtech/openssh:debian
    container_name: openssh
    ports:
      - "22:22"
    environment:
      - TZ=Asia/Shanghai
    volumes:
      - ~/.ssh/id_rsa.pub:/root/.ssh/authorized_keys:ro
    restart: unless-stopped
```

## Semantic Versioning Tags

Images follow semantic versioning with the format: `{version}-{variant}`

Examples:

- `snowdreamtech/openssh:10.0.2-debian`
- `snowdreamtech/openssh:10.3.2-alpine`
- `snowdreamtech/openssh:9.9.3-rocky`

This format allows:

- **Full version pinning**: `10.0.2-debian` (exact version)
- **Variant latest tag**: `latest-debian` (tracks most recent release for Debian)
- **Global latest tag**: `latest` (tracks most recent release, defaults to Debian)

## Architecture Support

Each distribution variant supports multiple CPU architectures for deployment across diverse hardware platforms:

| Variant | Architectures |
|---------|---------------|
| **Debian** | amd64, arm32v7, arm64, ppc64le, riscv64, s390x |
| **Alpine** | 386, amd64, arm/v6, arm/v7, arm64, ppc64le, riscv64, s390x |
| **Rocky** | amd64, arm64, ppc64le, s390x |

Docker automatically selects the appropriate architecture for your platform when pulling images.

## Entrypoint System

The image includes a flexible entrypoint system that executes custom initialization scripts in `/usr/local/bin/entrypoint.d/` before starting the OpenSSH server.

### How It Works

1. The `docker-entrypoint.sh` script runs at container startup
2. It executes all executable scripts in `/usr/local/bin/entrypoint.d/` in lexical order
3. Each script receives the container's command-line arguments
4. If any script fails, the container stops (fail-fast behavior)

## Development

### Prerequisites

- Docker (>= 20.10) with Docker Buildx plugin
- [UniRTM](https://github.com/snowdreamtech/UniRTM) for workspace quality guard and toolchain management

### Quality & Verification

```bash
# Setup toolchain and verify environment
unirtm run setup

# Run comprehensive workspace quality check (formatters, linters, security)
unirtm run verify

# Run security audits (Zizmor, Gitleaks, OSV-Scanner, Trivy)
unirtm run audit

# Automatically fix linting and formatting issues where supported
unirtm run fix
```

### Building Locally

```bash
# Build specific variant
docker build -t openssh:debian ./docker/debian/
docker build -t openssh:alpine ./docker/alpine/
docker build -t openssh:rocky ./docker/rocky/
```

### Testing

```bash
# Test OpenSSH version
docker run --rm openssh:debian ssh -V

# Test sshd configuration
docker run --rm openssh:debian sshd -t

# Test DEBUG mode
docker run --rm -e DEBUG=true openssh:debian
```

## Reference

1. [OpenSSH Official Website](https://www.openssh.com/)
2. [使用 buildx 构建多平台 Docker 镜像](https://icloudnative.io/posts/multiarch-docker-with-buildx/)
3. [如何使用 docker buildx 构建跨平台 Go 镜像](https://waynerv.com/posts/building-multi-architecture-images-with-docker-buildx/#buildx-%E7%9A%84%E8%B7%A8%E5%B9%B3%E5%8F%B0%E6%9E%84%E5%BB%BA%E7%AD%96%E7%95%A5)
4. [Building Multi-Arch Images for Arm and x86 with Docker Desktop](https://www.docker.com/blog/multi-arch-images/)
5. [How to Rapidly Build Multi-Architecture Images with Buildx](https://www.docker.com/blog/how-to-rapidly-build-multi-architecture-images-with-buildx/)
6. [Faster Multi-Platform Builds: Dockerfile Cross-Compilation Guide](https://www.docker.com/blog/faster-multi-platform-builds-dockerfile-cross-compilation-guide/)
7. [docker/buildx](https://github.com/docker/buildx)

## Contact (备注：openssh)

- Email: <sn0wdr1am@qq.com>
- QQ: 3217680847
- QQ群: 949022145
- WeChat/微信群: sn0wdr1am

## License

MIT
