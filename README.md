# OpenSSH

![Docker Image Version](https://img.shields.io/docker/v/snowdreamtech/openssh)
![Docker Image Size](https://img.shields.io/docker/image-size/snowdreamtech/openssh/latest)
![Docker Pulls](https://img.shields.io/docker/pulls/snowdreamtech/openssh)
![Docker Stars](https://img.shields.io/docker/stars/snowdreamtech/openssh)

Docker Image packaging for OpenSSH providing standardized container foundations with flexible entrypoint systems, multi-architecture support, and consistent configuration patterns across Alpine, Debian, and Rocky Linux distributions.

## Overview

This Docker image provides a secure, flexible, and ready-to-use OpenSSH server. It provides:

- **Pre-configured OpenSSH Server** with sensible defaults and multi-architecture support
- **Standardized Dockerfiles** with OCI annotations and best practices
- **Flexible entrypoint system** supporting custom initialization scripts
- **Consistent environment variable configuration** across all variants
- **Three distribution variants**: Alpine (lightweight), Debian (default/widely-compatible), Rocky (enterprise)

## Usage

This image runs an OpenSSH server. You can configure it by mounting your authorized keys or custom configuration files.

### 1. Passwordless Login (Recommended)

The most secure way to use this container is by mounting your public key to the `authorized_keys` file.

```bash
docker run -d   --name=openssh   -e TZ=Asia/Shanghai   -p 22:22   -v ~/.ssh/id_rsa.pub:/root/.ssh/authorized_keys:ro   --restart unless-stopped   snowdreamtech/openssh:latest
```

You can then log in using:
```bash
ssh root@localhost -p 22
```

### 2. Password Login

When the container starts for the first time without the `SSH_ROOT_CRED` environment variable, it automatically generates a random root password and prints it to the logs (`Generate random ssh root password: ...`). You can find it by running `docker logs openssh`.

If you want to set a fixed password, you can pass it via the `SSH_ROOT_CRED` environment variable, or change it in the running container:

```bash
# Start the container
docker run -d --name=openssh -p 22:22 snowdreamtech/openssh:latest

# Set root password
docker exec -it openssh sh -c "echo 'root:your_secure_password' | chpasswd"
```

### 3. Custom Configuration

If you want to use your own `sshd_config` or provide host keys to prevent SSH warnings when the container is recreated:

```bash
docker run -d   --name=openssh   -p 22:22   -v /my/custom/sshd_config:/etc/ssh/sshd_config:ro   -v /my/host/keys:/etc/ssh/   snowdreamtech/openssh:latest
```

### 4. Docker Compose Example

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
      - ~/.ssh/id_rsa.pub:/root/.ssh/authorized_keys:ro
      - ./data:/data
    restart: unless-stopped
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

**Supported Architectures**: 386, amd64, arm/v5, arm/v7, arm64, riscv64, ppc64le, s390x

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

## Environment Variables

All variants support the following environment variables for runtime configuration:

| Variable | Default | Description |
|----------|---------|-------------|
| `KEEPALIVE` | `0` | Keep container running (1=enabled, 0=disabled) |
| `CAP_NET_BIND_SERVICE` | `0` | Enable binding to privileged ports (<1024) |
| `LANG` | `C.UTF-8` | Locale setting for UTF-8 character support |
| `UMASK` | `022` | Default file creation mask |
| `DEBUG` | `false` | Enable debug output in entrypoint scripts |
| `PGID` | `0` | Primary group ID for custom user creation |
| `PUID` | `0` | User ID for custom user creation |
| `USER` | `root` | Username for custom user creation |
| `WORKDIR` | `/root` | Working directory path |
| `TZ` | - | Timezone (e.g., `Asia/Shanghai`, `America/New_York`) |

**Debian-specific**:

| Variable | Default | Description |
|----------|---------|-------------|
| `DEBIAN_FRONTEND` | `noninteractive` | Debian package installation mode |

## Semantic Versioning Tags

Images follow semantic versioning with the format: `{major}.{minor}.{patch}-{variant}`

Examples:

- `snowdreamtech/openssh:10.0.1-debian`
- `snowdreamtech/openssh:10.3.1-alpine`
- `snowdreamtech/openssh:9.9.1-rocky`

This format allows:

- **Full version pinning**: `10.0.1-debian` (exact version)
- **Variant latest tag**: `latest-debian` (tracks most recent release for Debian)
- **Global latest tag**: `latest` (tracks most recent release, defaults to Debian)

## Development

```bash
docker buildx create --use --name build --node build --driver-opt network=host

# Build Debian variant
docker buildx build -t snowdreamtech/openssh:debian --platform=linux/386,linux/amd64,linux/arm/v5,linux/arm/v7,linux/arm64,linux/riscv64,linux/ppc64le,linux/s390x ./docker/debian/

# Build Alpine variant
docker buildx build -t snowdreamtech/openssh:alpine --platform=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/riscv64,linux/s390x ./docker/alpine/

# Build Rocky variant
docker buildx build -t snowdreamtech/openssh:rocky --platform=linux/amd64,linux/arm64,linux/ppc64le,linux/s390x ./docker/rocky/
```

## Reference

1. [使用 buildx 构建多平台 Docker 镜像](https://icloudnative.io/posts/multiarch-docker-with-buildx/)
2. [如何使用 docker buildx 构建跨平台 Go 镜像](https://waynerv.com/posts/building-multi-architecture-images-with-docker-buildx/#buildx-%E7%9A%84%E8%B7%A8%E5%B9%B3%E5%8F%B0%E6%9E%84%E5%BB%BA%E7%AD%96%E7%95%A5)
3. [Building Multi-Arch Images for Arm and x86 with Docker Desktop](https://www.docker.com/blog/multi-arch-images/)
4. [How to Rapidly Build Multi-Architecture Images with Buildx](https://www.docker.com/blog/how-to-rapidly-build-multi-architecture-images-with-buildx/)
5. [Faster Multi-Platform Builds: Dockerfile Cross-Compilation Guide](https://www.docker.com/blog/faster-multi-platform-builds-dockerfile-cross-compilation-guide/)
6. [docker/buildx](https://github.com/docker/buildx)

## Contact (备注：openssh)

* Email: <sn0wdr1am@qq.com>
* QQ: 3217680847
* QQ群: 949022145
* WeChat/微信群: sn0wdr1am

## License

MIT
