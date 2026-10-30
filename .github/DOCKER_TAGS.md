# Docker Image Tags Reference

This document describes the Docker image tagging strategy for the OpenSSH project.

## Tag Naming Convention

All images use the format: `snowdreamtech/openssh:TAG`

Where `TAG` follows these patterns:

- **Variant-specific tags**: `TAG-variant` (e.g., `nightly-alpine`, `10.3.2-alpine`)
- **Default tags** (Debian only): `TAG` (e.g., `nightly`, `latest`, `10.0.2`)

## Supported Registries

All tags are pushed to two registries:

- **DockerHub**: `snowdreamtech/openssh:TAG`
- **GitHub Container Registry**: `ghcr.io/snowdreamtech/openssh:TAG`

## Tag Scenarios

### 1. Branch Builds (dev/main)

#### Push to `dev` branch

```bash
git push origin dev
```

**Generated tags:**

```
snowdreamtech/openssh:dev-alpine
snowdreamtech/openssh:dev-debian
snowdreamtech/openssh:dev              # ← Debian (default)
snowdreamtech/openssh:dev-rocky
```

#### Push to `main` branch

```bash
git push origin main
```

**Generated tags:**

```
snowdreamtech/openssh:main-alpine
snowdreamtech/openssh:latest-alpine
snowdreamtech/openssh:main-debian
snowdreamtech/openssh:latest-debian
snowdreamtech/openssh:main             # ← Debian (default)
snowdreamtech/openssh:latest           # ← Debian (default)
snowdreamtech/openssh:main-rocky
snowdreamtech/openssh:latest-rocky
```

---

### 2. Release Tags (Semantic Versioning)

#### Alpine Release

```bash
git tag alpine-v10.3.2
git push origin alpine-v10.3.2
```

**Generated tags:**

```
snowdreamtech/openssh:10.3.2-alpine
snowdreamtech/openssh:latest-alpine
```

#### Debian Release

```bash
git tag debian-v10.0.2
git push origin debian-v10.0.2
```

**Generated tags:**

```
snowdreamtech/openssh:10.0.2-debian
snowdreamtech/openssh:latest-debian
snowdreamtech/openssh:10.0.2           # ← Debian (default)
snowdreamtech/openssh:latest           # ← Debian (default)
```

#### Rocky Release

```bash
git tag rocky-v9.9.3
git push origin rocky-v9.9.3
```

**Generated tags:**

```
snowdreamtech/openssh:9.9.3-rocky
snowdreamtech/openssh:latest-rocky
```

---

### 3. Nightly Builds (Scheduled)

**Trigger:** Automatically every day at 17:00 UTC

**Generated tags:**

```
# Alpine
snowdreamtech/openssh:nightly-alpine
snowdreamtech/openssh:20260427-alpine

# Debian (with default tags)
snowdreamtech/openssh:nightly-debian
snowdreamtech/openssh:20260427-debian
snowdreamtech/openssh:nightly          # ← Debian (default)
snowdreamtech/openssh:20260427         # ← Debian (default)

# Rocky
snowdreamtech/openssh:nightly-rocky
snowdreamtech/openssh:20260427-rocky
```

---

## Tag Priority

Tags are generated with the following priority (higher number = higher priority):

| Priority | Type | Example Tags | Trigger |
|----------|------|--------------|---------|
| 1000 | Nightly | `nightly`, `nightly-alpine` | Schedule |
| 900 | Date | `20260427`, `20260427-alpine` | Schedule |
| 800 | Version | `10.3.2-alpine`, `10.0.2` | Tag push |
| 600 | Branch | `dev-alpine`, `main-debian` | Branch push |
| 200 | Latest | `latest`, `latest-alpine` | Main/Tag |

---

## Default Variant (Debian)

Debian is designated as the **default variant** (`is_latest: true`), which means:

✅ **Debian gets BOTH suffixed AND unsuffixed tags:**

```
snowdreamtech/openssh:nightly-debian   # Variant-specific
snowdreamtech/openssh:nightly          # Default (no suffix)

snowdreamtech/openssh:10.0.2-debian    # Variant-specific
snowdreamtech/openssh:10.0.2           # Default (no suffix)

snowdreamtech/openssh:latest-debian    # Variant-specific
snowdreamtech/openssh:latest           # Default (no suffix)
```

❌ **Alpine and Rocky get ONLY suffixed tags:**

```
snowdreamtech/openssh:nightly-alpine   # Variant-specific only
snowdreamtech/openssh:nightly-rocky    # Variant-specific only
```

---

## Usage Examples

### Pull the latest Debian image (default)

```bash
docker pull snowdreamtech/openssh:latest
# or
docker pull snowdreamtech/openssh:latest-debian
```

### Pull the latest Alpine image

```bash
docker pull snowdreamtech/openssh:latest-alpine
```

### Pull the latest Rocky image

```bash
docker pull snowdreamtech/openssh:latest-rocky
```

### Pull a specific version

```bash
# Alpine 10.3.2
docker pull snowdreamtech/openssh:10.3.2-alpine

# Debian 10.0.2 (two ways)
docker pull snowdreamtech/openssh:10.0.2-debian
docker pull snowdreamtech/openssh:10.0.2

# Rocky 9.9.3
docker pull snowdreamtech/openssh:9.9.3-rocky
```

### Pull nightly builds

```bash
# Alpine nightly
docker pull snowdreamtech/openssh:nightly-alpine

# Debian nightly (two ways)
docker pull snowdreamtech/openssh:nightly-debian
docker pull snowdreamtech/openssh:nightly

# Rocky nightly
docker pull snowdreamtech/openssh:nightly-rocky
```

---

## Tag Lifecycle

### Development Flow

```
1. Push to dev → base:dev-alpine, base:dev-debian, base:dev, base:dev-rocky
2. Push to main → base:main-alpine, base:latest-alpine, base:main-debian, base:latest-debian, base:main, base:latest, base:main-rocky, base:latest-rocky
3. Create tag → base:VERSION-variant, base:latest-variant (+ unsuffixed for Debian)
```

### Release Flow (with Release Please)

```
1. Merge PR to main → Release Please creates release PR
2. Merge release PR → Release Please creates tags (alpine-vX.Y.Z, debian-vX.Y.Z, rocky-vX.Y.Z)
3. Tag push triggers build → Images published with version tags
```

---

## Matrix Configuration

The workflow uses a matrix strategy with three variants:

```yaml
matrix:
  include:
    - variant: alpine
      version: "10.3.2"
      is_latest: false

    - variant: debian
      version: "10.0.2"
      is_latest: true    # ← Default variant

    - variant: rocky
      version: "9.9.3"
      is_latest: false
```

Only the variant with `is_latest: true` receives unsuffixed tags.

---

## Metadata Action Configuration

The key configuration that enables this tagging strategy:

```yaml
images: |
  name=snowdreamtech/openssh,enable=true
  name=ghcr.io/snowdreamtech/openssh,enable=true
flavor: |
  latest=false
  prefix=
  suffix=-${{ matrix.variant }}  # ← Adds variant suffix to all tags
```

For Debian (is_latest), additional rules generate unsuffixed tags:

```yaml
type=raw,enable=${{ matrix.is_latest }},priority=1000,prefix=,suffix=,pattern=nightly
```

This creates both `nightly-debian` (from flavor suffix) and `nightly` (from this rule).
