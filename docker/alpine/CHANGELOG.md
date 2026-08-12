# Changelog

## [10.3.2](https://github.com/snowdreamtech/openssh/compare/alpine-v10.3.1...alpine-v10.3.2) (2026-08-12)


### 🐛 Bug Fixes

* remove static version defaults from OCI image labels to use variable injection exclusively ([da5645a](https://github.com/snowdreamtech/openssh/commit/da5645ad4d48467290235abbbd9f31ba70bf690f))
* use ghcr.io for base images to avoid rate limits ([9f1d73a](https://github.com/snowdreamtech/openssh/commit/9f1d73a75a61f2f368f5572c4bd28f4c92ef8fd5))


### ♻️ Miscellaneous Chores

* add 0-git-keep.sh to prevent empty entrypoint.d directories ([ce77247](https://github.com/snowdreamtech/openssh/commit/ce77247762becc1edf85ec7b57747d3f3127044a))
* **merge:** merge upstream/dev into dev ([db5b673](https://github.com/snowdreamtech/openssh/commit/db5b673e3a61812b5b1c9255d90ceeaafbd645a2))
* release main ([5a92edb](https://github.com/snowdreamtech/openssh/commit/5a92edb4ba76b04ee6de7369e9471f785849a7ae))
* release main ([afa286c](https://github.com/snowdreamtech/openssh/commit/afa286c5b9c41908021b044f31fee3348f52c973))
* release main ([4011a21](https://github.com/snowdreamtech/openssh/commit/4011a21a23395acc9545168c95ca0ec5c867e7d3))
* release main ([f66597a](https://github.com/snowdreamtech/openssh/commit/f66597a5feae95e8853f4cc730c81e93e172f6ca))
* release main ([b3a5cc9](https://github.com/snowdreamtech/openssh/commit/b3a5cc9ef0a64a7bc04ed7c2acf0cca5327c5c26))
* **release:** deduplicate CHANGELOG headers ([c2bba24](https://github.com/snowdreamtech/openssh/commit/c2bba247dca89a31accc6e70c5e48b16170b1ce5))
* **release:** deduplicate CHANGELOG headers ([4f07b71](https://github.com/snowdreamtech/openssh/commit/4f07b71194f58ba214f1fb60ce0dc56d71c499e2))
* **release:** deduplicate CHANGELOG headers ([82be3d5](https://github.com/snowdreamtech/openssh/commit/82be3d5576b65b7f69b1a9afb8604f2c8f0e47f7))
* update alpine base image to 3.24.1 ([3021ed3](https://github.com/snowdreamtech/openssh/commit/3021ed3b4ffa5f8916f5fa46aa4325e8ebf84ba6))

## [10.3.1](https://github.com/snowdreamtech/openssh/compare/alpine-v10.3.1...alpine-v10.3.1) (2026-06-20)


### 🐛 Bug Fixes

* **docker:** add missing EXPOSE 22 instruction to all dockerfiles ([746e55a](https://github.com/snowdreamtech/openssh/commit/746e55a679d633f4a22c8d38a129071e41cfed82))
* **docker:** enhance sshd_config regex robustness and add motd auto-refresh ([eeb5a5b](https://github.com/snowdreamtech/openssh/commit/eeb5a5bc8facfa4a85816c35fdb86022f6f575f5))
* **docker:** ensure explicit permissions for client ssh keys generation ([f2b50df](https://github.com/snowdreamtech/openssh/commit/f2b50dfdc0f41dab96fc2734653a2c1a36c484c3))
* **docker:** explicitly add executable permissions for motd script in alpine and rocky ([1bd73f2](https://github.com/snowdreamtech/openssh/commit/1bd73f21cc8b5b8336ed57498b47f2eb72de2628))
* **docker:** remove redundant client ssh keys generation from entrypoint ([24c2b71](https://github.com/snowdreamtech/openssh/commit/24c2b71eef260edccfa2b35a855994361a0f95fd))
