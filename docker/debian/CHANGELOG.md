# Changelog

## [10.0.2](https://github.com/snowdreamtech/openssh/compare/debian-v10.0.2...debian-v10.0.2) (2026-10-30)


### 🚀 Features

* align with base dev template and retain openssh docker configs ([19bd516](https://github.com/snowdreamtech/openssh/commit/19bd5169ac10fdf09fcbf15bcab6c2dbc1574bc4))
* initial release of snowdreamtech base docker images powered by unirtm ([25f55c8](https://github.com/snowdreamtech/openssh/commit/25f55c84e8fba977d226739e9871d61e1428fdeb))


### ♻️ Miscellaneous Chores

* release main ([a2cafdc](https://github.com/snowdreamtech/openssh/commit/a2cafdc012ed85559e0239e6333af767a878eff8))
* **release:** deduplicate CHANGELOG headers ([ec1c2ef](https://github.com/snowdreamtech/openssh/commit/ec1c2ef80d3e6af152487494cd1727eaf502214b))

## [10.0.1](https://github.com/snowdreamtech/openssh/compare/debian-v10.0.1...debian-v10.0.1) (2026-06-20)


### 🐛 Bug Fixes

* **docker:** add missing EXPOSE 22 instruction to all dockerfiles ([746e55a](https://github.com/snowdreamtech/openssh/commit/746e55a679d633f4a22c8d38a129071e41cfed82))
* **docker:** enhance sshd_config regex robustness and add motd auto-refresh ([eeb5a5b](https://github.com/snowdreamtech/openssh/commit/eeb5a5bc8facfa4a85816c35fdb86022f6f575f5))
* **docker:** ensure explicit permissions for client ssh keys generation ([f2b50df](https://github.com/snowdreamtech/openssh/commit/f2b50dfdc0f41dab96fc2734653a2c1a36c484c3))
* **docker:** remove redundant client ssh keys generation from entrypoint ([24c2b71](https://github.com/snowdreamtech/openssh/commit/24c2b71eef260edccfa2b35a855994361a0f95fd))
