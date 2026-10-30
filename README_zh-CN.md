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

OpenSSH 服务端 Docker 镜像，提供标准化的容器基础，具有灵活的入口点系统、多架构支持以及跨 Alpine、Debian 和 Rocky Linux 发行版的一致配置模式。

## 概述

这些 OpenSSH Docker 镜像作为安全、灵活且开箱即用的 OpenSSH 服务端容器。它提供：

- **标准化的 Dockerfile**，包含 OCI 注释和最佳实践
- **预配置的 OpenSSH 服务端**，具备合理的默认配置并支持多架构
- **自动主机密钥生成**
- **灵活的入口点系统**，支持自定义初始化脚本
- **一致的环境变量配置**，适用于所有变体
- **多架构支持**，适用于多样化的硬件平台
- **用户/组管理**，支持 PUID/PGID 进行权限处理
- **三种发行版变体**：Alpine（轻量级）、Debian（默认/广泛兼容）、Rocky（企业级）

## 快速开始

```bash
# 拉取并运行默认的 Debian 变体
docker pull snowdreamtech/openssh:debian
docker run -d --name=openssh -p 22:22 -e TZ=Asia/Shanghai snowdreamtech/openssh:debian

# 或使用 docker compose
docker compose up -d
```

## 使用方法

### 1. 免密登录（推荐）

将您的公钥挂载到 `/root/.ssh/authorized_keys` 以使用密钥认证：

```bash
docker run -d \
  --name=openssh \
  -e TZ=Asia/Shanghai \
  -p 22:22 \
  -v ~/.ssh/id_rsa.pub:/root/.ssh/authorized_keys:ro \
  --restart unless-stopped \
  snowdreamtech/openssh:latest
```

登录：

```bash
ssh root@localhost -p 22
```

### 2. 密码登录

当容器在没有 `SSH_ROOT_CRED` 的情况下启动时，它会自动生成一个随机密码并在日志中打印：

```bash
docker logs openssh
```

如需设置固定密码：

```bash
docker run -d \
  --name=openssh \
  -e SSH_ROOT_CRED=your_secure_password \
  -p 22:22 \
  --restart unless-stopped \
  snowdreamtech/openssh:latest
```

或在运行中的容器中更改：

```bash
docker exec -it openssh sh -c "echo 'root:your_secure_password' | chpasswd"
```

### 3. 自定义配置

如果您想使用自定义的 `sshd_config` 或挂载主机密钥（防止容器重新创建时报 SSH 密钥变动警告）：

```bash
docker run -d \
  --name=openssh \
  -p 22:22 \
  -v /my/custom/sshd_config:/etc/ssh/sshd_config:ro \
  -v /my/host/keys:/etc/ssh/ \
  snowdreamtech/openssh:latest
```

## 发行版变体

### Debian（默认）

推荐用于大多数场景，提供广泛的兼容性和丰富的软件包生态。

```bash
docker run -d \
  --name=openssh \
  -e TZ=Asia/Shanghai \
  -p 22:22 \
  --restart unless-stopped \
  snowdreamtech/openssh:debian
```

**支持的架构**: amd64, arm32v7, arm64, ppc64le, riscv64, s390x

**基础镜像**: `snowdreamtech/debian:13.6.0`

### Alpine

经过轻量化优化的变体，具有极小的镜像体积和极快的启动速度。

```bash
docker run -d \
  --name=openssh \
  -e TZ=Asia/Shanghai \
  -p 22:22 \
  --restart unless-stopped \
  snowdreamtech/openssh:alpine
```

**支持的架构**: 386, amd64, arm/v6, arm/v7, arm64, ppc64le, riscv64, s390x

**基础镜像**: `snowdreamtech/alpine:3.24.1`

### Rocky

基于 Rocky Linux 的企业级变体，适合需要与 RHEL 完全兼容的生产环境。

```bash
docker run -d \
  --name=openssh \
  -e TZ=Asia/Shanghai \
  -p 22:22 \
  --restart unless-stopped \
  snowdreamtech/openssh:rocky
```

**支持的架构**: amd64, arm64, ppc64le, s390x

**基础镜像**: `snowdreamtech/rocky:10.2.0`

## 构建说明

### 单架构构建

```bash
# 构建 Debian 变体
docker build -t snowdreamtech/openssh:debian ./docker/debian/

# 构建 Alpine 变体
docker build -t snowdreamtech/openssh:alpine ./docker/alpine/

# 构建 Rocky 变体
docker build -t snowdreamtech/openssh:rocky ./docker/rocky/
```

### 多架构构建

使用 `docker buildx` 构建多平台镜像：

```bash
# 创建并使用 buildx 构建器
docker buildx create --use --name build --node build --driver-opt network=host

# 构建 Debian 多架构镜像
docker buildx build \
  --platform=linux/amd64,linux/arm/v7,linux/arm64,linux/ppc64le,linux/riscv64,linux/s390x \
  -t snowdreamtech/openssh:debian \
  ./docker/debian/ \
  --push

# 构建 Alpine 多架构镜像
docker buildx build \
  --platform=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/riscv64,linux/s390x \
  -t snowdreamtech/openssh:alpine \
  ./docker/alpine/ \
  --push

# 构建 Rocky 多架构镜像
docker buildx build \
  --platform=linux/amd64,linux/arm64,linux/ppc64le,linux/s390x \
  -t snowdreamtech/openssh:rocky \
  ./docker/rocky/ \
  --push
```

## 环境变量

所有变体均支持以下环境变量进行运行时配置：

| 变量 | 默认值 | 描述 |
|------|--------|------|
| `SSH_ROOT_CRED` | - | Root 密码（未设置时将自动随机生成） |
| `KEEPALIVE` | `0` | 保持容器持续运行（1=启用，0=禁用） |
| `CAP_NET_BIND_SERVICE` | `0` | 允许非 root 绑定特权端口（<1024） |
| `LANG` | `C.UTF-8` | 支持 UTF-8 字符的区域语言设置 |
| `UMASK` | `022` | 默认文件创建掩码 |
| `DEBUG` | `false` | 在入口点脚本中启用调试输出 |
| `PASSWORDLESS_SUDO` | `false` | 为非 root 用户启用免密 sudo（true/false） |
| `PGID` | `0` | 自定义用户主组 ID |
| `PUID` | `0` | 自定义用户 ID |
| `USER` | `root` | 自定义用户名称 |
| `WORKDIR` | `/root` | 工作目录路径 |
| `TZ` | - | 时区（例如 `Asia/Shanghai`, `America/New_York`） |
| `OPENSSH_VERSION` | 视版本而定 | 安装的 OpenSSH 软件包版本 |

**Debian 专属变量**:

| 变量 | 默认值 | 描述 |
|------|--------|------|
| `DEBIAN_FRONTEND` | `noninteractive` | Debian 软件包安装模式 |

## Docker Compose 示例

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

## 语义化版本标签

镜像遵循语义化版本规范，标签格式为：`{version}-{variant}`

示例：

- `snowdreamtech/openssh:10.0.2-debian`
- `snowdreamtech/openssh:10.3.2-alpine`
- `snowdreamtech/openssh:9.9.3-rocky`

这种格式支持：

- **完整版本固定**: `10.0.2-debian`（精确版本）
- **变体最新标签**: `latest-debian`（跟踪 Debian 分支的最新版本）
- **全局最新标签**: `latest`（跟踪最新发布，默认为 Debian）

## 架构支持

每个发行版变体均支持多 CPU 架构部署：

| 变体 | 支持架构 |
|------|----------|
| **Debian** | amd64, arm32v7, arm64, ppc64le, riscv64, s390x |
| **Alpine** | 386, amd64, arm/v6, arm/v7, arm64, ppc64le, riscv64, s390x |
| **Rocky** | amd64, arm64, ppc64le, s390x |

拉取镜像时，Docker 会自动选择适配您平台的架构。

## 入口点系统

镜像包含灵活的入口点系统，在启动 OpenSSH 服务前按顺序执行 `/usr/local/bin/entrypoint.d/` 中的自定义初始化脚本。

### 工作原理

1. `docker-entrypoint.sh` 脚本在容器启动时执行
2. 按字典顺序执行 `/usr/local/bin/entrypoint.d/` 中的所有可执行脚本
3. 每个脚本都会接收容器的命令行参数
4. 任何脚本执行失败都会导致容器立即终止（快速失败机制）

## 开发指南

### 前置要求

- Docker (>= 20.10) 与 Docker Buildx 插件
- [UniRTM](https://github.com/snowdreamtech/UniRTM) 用于工作区质量守卫与工具链管理

### 质量与验证

```bash
# 配置工具链并验证环境
unirtm run setup

# 执行全面的工作区质量检查（代码格式化、静态分析、安全审计）
unirtm run verify

# 执行安全审计（Zizmor, Gitleaks, OSV-Scanner, Trivy）
unirtm run audit

# 自动修复支持的格式化和静态分析问题
unirtm run fix
```

### 本地构建

```bash
# 构建指定变体
docker build -t openssh:debian ./docker/debian/
docker build -t openssh:alpine ./docker/alpine/
docker build -t openssh:rocky ./docker/rocky/
```

### 验证与测试

```bash
# 测试 OpenSSH 版本
docker run --rm openssh:debian ssh -V

# 测试 sshd 配置有效性
docker run --rm openssh:debian sshd -t

# 测试调试模式
docker run --rm -e DEBUG=true openssh:debian
```

## 参考链接

1. [OpenSSH 官方网站](https://www.openssh.com/)
2. [使用 buildx 构建多平台 Docker 镜像](https://icloudnative.io/posts/multiarch-docker-with-buildx/)
3. [如何使用 docker buildx 构建跨平台 Go 镜像](https://waynerv.com/posts/building-multi-architecture-images-with-docker-buildx/#buildx-%E7%9A%84%E8%B7%A8%E5%B9%B3%E5%8F%B0%E6%9E%84%E5%BB%BA%E7%AD%96%E7%95%A5)
4. [Building Multi-Arch Images for Arm and x86 with Docker Desktop](https://www.docker.com/blog/multi-arch-images/)
5. [How to Rapidly Build Multi-Architecture Images with Buildx](https://www.docker.com/blog/how-to-rapidly-build-multi-architecture-images-with-buildx/)
6. [Faster Multi-Platform Builds: Dockerfile Cross-Compilation Guide](https://www.docker.com/blog/faster-multi-platform-builds-dockerfile-cross-compilation-guide/)
7. [docker/buildx](https://github.com/docker/buildx)

## 联系方式 (备注：openssh)

- 邮箱: <sn0wdr1am@qq.com>
- QQ: 3217680847
- QQ群: 949022145
- 微信/微信群: sn0wdr1am

## 许可证

MIT
