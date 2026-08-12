# Changelog

## [9.9.2](https://github.com/snowdreamtech/openssh/compare/rocky-v9.9.1...rocky-v9.9.2) (2026-08-12)


### 🐛 Bug Fixes

* remove static version defaults from OCI image labels to use variable injection exclusively ([da5645a](https://github.com/snowdreamtech/openssh/commit/da5645ad4d48467290235abbbd9f31ba70bf690f))
* use ghcr.io for base images to avoid rate limits ([9f1d73a](https://github.com/snowdreamtech/openssh/commit/9f1d73a75a61f2f368f5572c4bd28f4c92ef8fd5))


### ♻️ Miscellaneous Chores

* add 0-git-keep.sh to prevent empty entrypoint.d directories ([ce77247](https://github.com/snowdreamtech/openssh/commit/ce77247762becc1edf85ec7b57747d3f3127044a))
* **docker:** ignore unavailable repos for rocky multi-arch build ([a87b246](https://github.com/snowdreamtech/openssh/commit/a87b246961240c2fde70c7c8ddc1d143163c640e))
* **merge:** merge upstream/dev into dev ([db5b673](https://github.com/snowdreamtech/openssh/commit/db5b673e3a61812b5b1c9255d90ceeaafbd645a2))
* release main ([5a92edb](https://github.com/snowdreamtech/openssh/commit/5a92edb4ba76b04ee6de7369e9471f785849a7ae))
* release main ([4011a21](https://github.com/snowdreamtech/openssh/commit/4011a21a23395acc9545168c95ca0ec5c867e7d3))
* release main ([d52be5c](https://github.com/snowdreamtech/openssh/commit/d52be5cf0c5cff45f7f72e973d62c94b48855e1b))
* release main ([f66597a](https://github.com/snowdreamtech/openssh/commit/f66597a5feae95e8853f4cc730c81e93e172f6ca))
* release main ([b3a5cc9](https://github.com/snowdreamtech/openssh/commit/b3a5cc9ef0a64a7bc04ed7c2acf0cca5327c5c26))
* **release:** deduplicate CHANGELOG headers ([c2bba24](https://github.com/snowdreamtech/openssh/commit/c2bba247dca89a31accc6e70c5e48b16170b1ce5))
* **release:** deduplicate CHANGELOG headers ([4f07b71](https://github.com/snowdreamtech/openssh/commit/4f07b71194f58ba214f1fb60ce0dc56d71c499e2))
* **release:** deduplicate CHANGELOG headers ([3068d88](https://github.com/snowdreamtech/openssh/commit/3068d883bc6167773d046d3b2b0e4c479e4fee39))
* **release:** deduplicate CHANGELOG headers ([82be3d5](https://github.com/snowdreamtech/openssh/commit/82be3d5576b65b7f69b1a9afb8604f2c8f0e47f7))
* **speckit:** manual auto-commit trigger ([5f8a5a9](https://github.com/snowdreamtech/openssh/commit/5f8a5a9cba5d6bd42a65eaabfecd6e18b01aeeb0))

## [9.9.1](https://github.com/snowdreamtech/openssh/compare/rocky-v9.9.1...rocky-v9.9.1) (2026-06-21)


### 🐛 Bug Fixes

* **docker:** use hyphen for version pinning in dnf5 for rocky ([bda1179](https://github.com/snowdreamtech/openssh/commit/bda1179dc08b7d1af2ec031700380cb213cc71b8))
