# OpenSSH

![Docker Image Version](https://img.shields.io/docker/v/snowdreamtech/openssh)
![Docker Image Size](https://img.shields.io/docker/image-size/snowdreamtech/openssh/latest)
![Docker Pulls](https://img.shields.io/docker/pulls/snowdreamtech/openssh)
![Docker Stars](https://img.shields.io/docker/stars/snowdreamtech/openssh)

基于 Alpine, Debian 和 Rocky Linux 的 OpenSSH Docker 镜像，提供标准化的容器基础架构、灵活的 entrypoint 系统、多架构支持以及一致的配置模式。

## 简介

此 Docker 镜像提供了安全、灵活且开箱即用的 OpenSSH 服务器，包括：

- **预配置的 OpenSSH 服务器**：具有合理的默认配置和多架构支持
- **标准化的 Dockerfile**：遵循 OCI 规范和最佳实践
- **灵活的入口系统**：支持自定义初始化脚本
- **一致的环境变量配置**：跨所有系统版本保持一致
- **三大系统分支**：Alpine（轻量级）、Debian（默认/高兼容性）、Rocky（企业级）

## 快速开始

可以使用 docker-compose 或 docker cli 快速启动此镜像的容器。

### Docker Cli

#### 简单模式

```bash
docker run -d \
  --name=openssh \
  -e TZ=Asia/Shanghai \
  -p 22:22 \
  --restart unless-stopped \
  snowdreamtech/openssh:latest
```

#### 高级模式

```bash
docker run -d \
  --name=openssh \
  -e TZ=Asia/Shanghai \
  -v /path/to/data:/path/to/data \
  -p 22:22 \
  --restart unless-stopped \
  snowdreamtech/openssh:latest
```

### Docker Compose

#### 简单模式

```yaml
services:
  openssh:
    image: snowdreamtech/openssh:latest
    container_name: openssh
    ports:
      - '22:22'
    environment:
      - TZ=Asia/Shanghai
    restart: unless-stopped
```

#### 高级模式

```yaml
services:
  openssh:
    image: snowdreamtech/openssh:latest
    container_name: openssh
    ports:
      - '22:22'
    environment:
      - TZ=Asia/Shanghai
    volumes:
      - /path/to/data:/path/to/data
    restart: unless-stopped
```

## 系统分支

### Debian (默认)

适用于大多数场景的推荐分支，提供广泛的兼容性和丰富的软件包。

```bash
docker run -d \
  --name=openssh \
  -e TZ=Asia/Shanghai \
  -p 22:22 \
  --restart unless-stopped \
  snowdreamtech/openssh:debian
```

**支持的架构**: i386, amd64, arm32v5, arm32v7, arm64, mips64le, ppc64le, s390x

### Alpine

轻量级分支，针对最小化镜像体积和极速启动进行了优化。

```bash
docker run -d \
  --name=openssh \
  -e TZ=Asia/Shanghai \
  -p 22:22 \
  --restart unless-stopped \
  snowdreamtech/openssh:alpine
```

**支持的架构**: i386, amd64, arm32v6, arm32v7, arm64, ppc64le, riscv64, s390x

### Rocky

基于 Rocky Linux 的企业级分支，非常适合需要 RHEL 兼容性的生产环境。

```bash
docker run -d \
  --name=openssh \
  -e TZ=Asia/Shanghai \
  -p 22:22 \
  --restart unless-stopped \
  snowdreamtech/openssh:rocky
```

**支持的架构**: i386, amd64, arm32v5, arm32v7, arm64, mips64le, ppc64le, s390x

## 环境变量

所有分支均支持以下环境变量来进行运行时配置：

| 变量 | 默认值 | 说明 |
|----------|---------|-------------|
| `KEEPALIVE` | `0` | 保持容器运行 (1=启用, 0=禁用) |
| `CAP_NET_BIND_SERVICE` | `0` | 允许绑定特权端口 (<1024) |
| `LANG` | `C.UTF-8` | 支持 UTF-8 字符的语言环境设置 |
| `UMASK` | `022` | 默认文件创建掩码 |
| `DEBUG` | `false` | 在 entrypoint 脚本中启用调试输出 |
| `PGID` | `0` | 自定义用户的属组 ID |
| `PUID` | `0` | 自定义用户的用户 ID |
| `USER` | `root` | 自定义用户的用户名 |
| `WORKDIR` | `/root` | 工作目录路径 |
| `TZ` | - | 时区 (如 `Asia/Shanghai`, `America/New_York`) |

**Debian 专属**:

| 变量 | 默认值 | 说明 |
|----------|---------|-------------|
| `DEBIAN_FRONTEND` | `noninteractive` | Debian 软件包安装模式 |

## 语义化版本号标签

镜像遵循语义化版本控制，格式为：`{major}.{minor}.{patch}-{variant}`

示例：

- `snowdreamtech/openssh:10.0.1-debian`
- `snowdreamtech/openssh:10.3.1-alpine`
- `snowdreamtech/openssh:9.9.1-rocky`

该格式支持：

- **精确版本锁定**: `10.0.1-debian` (固定版本)
- **特定分支的最新标签**: `latest-debian` (跟踪 Debian 分支的最新发布)
- **全局最新标签**: `latest` (跟踪最新发布，默认指向 Debian 分支)

## 开发

```bash
docker buildx create --use --name build --node build --driver-opt network=host

# 构建 Debian 分支
docker buildx build -t snowdreamtech/openssh:debian --platform=linux/386,linux/amd64,linux/arm/v5,linux/arm/v7,linux/arm64,linux/mips64le,linux/ppc64le,linux/s390x ./docker/debian/

# 构建 Alpine 分支
docker buildx build -t snowdreamtech/openssh:alpine --platform=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/riscv64,linux/s390x ./docker/alpine/

# 构建 Rocky 分支
docker buildx build -t snowdreamtech/openssh:rocky --platform=linux/386,linux/amd64,linux/arm/v5,linux/arm/v7,linux/arm64,linux/mips64le,linux/ppc64le,linux/s390x ./docker/rocky/
```

## 参考链接

1. [使用 buildx 构建多平台 Docker 镜像](https://icloudnative.io/posts/multiarch-docker-with-buildx/)
2. [如何使用 docker buildx 构建跨平台 Go 镜像](https://waynerv.com/posts/building-multi-architecture-images-with-docker-buildx/#buildx-%E7%9A%84%E8%B7%A8%E5%B9%B3%E5%8F%B0%E6%9E%84%E5%BB%BA%E7%AD%96%E7%95%A5)
3. [Building Multi-Arch Images for Arm and x86 with Docker Desktop](https://www.docker.com/blog/multi-arch-images/)
4. [How to Rapidly Build Multi-Architecture Images with Buildx](https://www.docker.com/blog/how-to-rapidly-build-multi-architecture-images-with-buildx/)
5. [Faster Multi-Platform Builds: Dockerfile Cross-Compilation Guide](https://www.docker.com/blog/faster-multi-platform-builds-dockerfile-cross-compilation-guide/)
6. [docker/buildx](https://github.com/docker/buildx)

## 联系方式 (备注：openssh)

* Email: <sn0wdr1am@qq.com>
* QQ: 3217680847
* QQ群: 949022145
* WeChat/微信群: sn0wdr1am

## License

MIT
