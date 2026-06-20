# Changelog

## [9.9.1](https://github.com/snowdreamtech/openssh/compare/rocky-v9.9.1...rocky-v9.9.1) (2026-06-20)


### 🐛 Bug Fixes

* **docker:** add missing EXPOSE 22 instruction to all dockerfiles ([746e55a](https://github.com/snowdreamtech/openssh/commit/746e55a679d633f4a22c8d38a129071e41cfed82))
* **docker:** enhance sshd_config regex robustness and add motd auto-refresh ([eeb5a5b](https://github.com/snowdreamtech/openssh/commit/eeb5a5bc8facfa4a85816c35fdb86022f6f575f5))
* **docker:** ensure explicit permissions for client ssh keys generation ([f2b50df](https://github.com/snowdreamtech/openssh/commit/f2b50dfdc0f41dab96fc2734653a2c1a36c484c3))
* **docker:** explicitly add executable permissions for motd script in alpine and rocky ([1bd73f2](https://github.com/snowdreamtech/openssh/commit/1bd73f21cc8b5b8336ed57498b47f2eb72de2628))
* **docker:** remove redundant client ssh keys generation from entrypoint ([24c2b71](https://github.com/snowdreamtech/openssh/commit/24c2b71eef260edccfa2b35a855994361a0f95fd))

## [9.9.1](https://github.com/snowdreamtech/openssh/compare/rocky-v9.9.1...rocky-v9.9.1) (2026-06-20)


### 🚀 Features

* **docker:** add openssh startup scripts from main branch ([ff61667](https://github.com/snowdreamtech/openssh/commit/ff61667d459b4d192a898966197be94c51de1ccd))


### 🐛 Bug Fixes

* **docker:** align architecture metadata in Dockerfiles with build matrix ([cbc4f4b](https://github.com/snowdreamtech/openssh/commit/cbc4f4b1603a659f6667e217d422ecebf7405692))
* **docker:** correct base.name and release-please annotations ([5679f14](https://github.com/snowdreamtech/openssh/commit/5679f14bb543e00d79f85cf78ae69cf89fcadb10))


### 🛠 Refactoring

* **docker:** align Dockerfiles with base image structure ([232574f](https://github.com/snowdreamtech/openssh/commit/232574fed8418f8c7f257d001e951361dfa467a0))
* **docker:** update CMD to sshd and unify motd mechanism ([6a6f81f](https://github.com/snowdreamtech/openssh/commit/6a6f81f361377a583dab25ecbd731b5f5c1cd213))
* remove redundant docker-entrypoint.sh files ([87c576b](https://github.com/snowdreamtech/openssh/commit/87c576b27731ad11c5bc0ebc661e07c5a09ff1c1))
* reorganize distribution variants into docker directory ([67a8c91](https://github.com/snowdreamtech/openssh/commit/67a8c911e21801bf12b3e83d02e22f3b3f59a2ba))


### 📖 Documentation

* add detailed comments to entrypoint initialization scripts ([f42cbaa](https://github.com/snowdreamtech/openssh/commit/f42cbaab6edfbc5c38c2a636dfd8651fea900940))


### ♻️ Miscellaneous Chores

* clear all CHANGELOG history for fresh start ([91df6dc](https://github.com/snowdreamtech/openssh/commit/91df6dcfa4b64e71b59576fa398c99dc784f293b))
* **deps:** bump base images to alpine 3.24.0, debian 13.5.0, rocky 10.2.0 ([1688969](https://github.com/snowdreamtech/openssh/commit/168896956d2f4c7f91309c4c98ffef36ca7e8546))
* release main ([deb8454](https://github.com/snowdreamtech/openssh/commit/deb8454df7518d56939ab3851245a4cd7b03d709))
* release main ([d87cb81](https://github.com/snowdreamtech/openssh/commit/d87cb815685ad9b5b43d4b9a195c68dee2fd8065))
* release main ([78328d2](https://github.com/snowdreamtech/openssh/commit/78328d20bd3697d48ea90aee8d0eaa6af4ccc09c))
* release main ([b720ad5](https://github.com/snowdreamtech/openssh/commit/b720ad57dd1691d8ae07dcac7d46d0bd257af3a0))
* release main ([32dd84d](https://github.com/snowdreamtech/openssh/commit/32dd84de4be973395d0867b5d527d528948a35df))
* release main ([725c69f](https://github.com/snowdreamtech/openssh/commit/725c69fdcc222b5b83d0690629ce213a68c586ab))
* release main ([070b694](https://github.com/snowdreamtech/openssh/commit/070b694a702763b60fc6b057a81418320418cafa))
* release main ([36d1211](https://github.com/snowdreamtech/openssh/commit/36d1211036847a8c6aaa01a21a1c695a47b71d45))
* release main ([9ad4f94](https://github.com/snowdreamtech/openssh/commit/9ad4f9490832efdc310f2ebbd8c77f3404daf07f))
* release main ([b0684a3](https://github.com/snowdreamtech/openssh/commit/b0684a32a652e83506451e6056168cfec8b9142c))
* release main ([495e18a](https://github.com/snowdreamtech/openssh/commit/495e18a4babcb06a12c2f5aec9ea571d97cb32e3))
* release main ([d4a3a34](https://github.com/snowdreamtech/openssh/commit/d4a3a34b00a6b9f381cd5d556749c257516b2f08))
* release main ([28d9426](https://github.com/snowdreamtech/openssh/commit/28d94263f4374017274707faef7183917b689be9))
* **release:** deduplicate CHANGELOG headers ([d47fb44](https://github.com/snowdreamtech/openssh/commit/d47fb44cb105b368722d7d0e210a27b525f82d87))
* **release:** deduplicate CHANGELOG headers ([e795177](https://github.com/snowdreamtech/openssh/commit/e79517795d98b9f8292ef956586a6dc03932d03c))
* **release:** deduplicate CHANGELOG headers ([27919e4](https://github.com/snowdreamtech/openssh/commit/27919e4baf4aab5b2a2bf32a7d437b05a717c11b))
* **release:** deduplicate CHANGELOG headers ([438190d](https://github.com/snowdreamtech/openssh/commit/438190d297c151c75eca4912fdc22c285d5ec1ea))
* **release:** deduplicate CHANGELOG headers ([256f043](https://github.com/snowdreamtech/openssh/commit/256f04311b2344f2648ca5bcf407146f8c690258))
* **release:** deduplicate CHANGELOG headers ([d263aae](https://github.com/snowdreamtech/openssh/commit/d263aae7b223103a01dd0e114430381c5d863dd7))
* **release:** deduplicate CHANGELOG headers ([133954e](https://github.com/snowdreamtech/openssh/commit/133954e95cfae85cbba2fb9c1ac5acbc677ca39d))
* **release:** deduplicate CHANGELOG headers ([1d82410](https://github.com/snowdreamtech/openssh/commit/1d82410d6038be22d7741f1519826f30023b0f3e))
* **release:** deduplicate CHANGELOG headers ([5e1a539](https://github.com/snowdreamtech/openssh/commit/5e1a5390319933b48d20ad993714587d826c0aa7))
* **release:** implement automatic changelog deduplication step ([282c220](https://github.com/snowdreamtech/openssh/commit/282c22081e1ad7a1a010a7f297d20bc7c9b416a7))
* remove placeholder 10-base-init.sh scripts ([0debe25](https://github.com/snowdreamtech/openssh/commit/0debe25f4ae5fdc4ca0a658bb28ad1663959b8c6))

<!-- DO NOT EDIT MANUALLY - This file is managed by automated professional tools -->
## Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
