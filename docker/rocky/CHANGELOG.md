# Changelog

## [9.9.1](https://github.com/snowdreamtech/openssh/compare/rocky-v9.9.1...rocky-v9.9.1) (2026-06-20)


### 🐛 Bug Fixes

* **docker:** add missing EXPOSE 22 instruction to all dockerfiles ([746e55a](https://github.com/snowdreamtech/openssh/commit/746e55a679d633f4a22c8d38a129071e41cfed82))
* **docker:** enhance sshd_config regex robustness and add motd auto-refresh ([eeb5a5b](https://github.com/snowdreamtech/openssh/commit/eeb5a5bc8facfa4a85816c35fdb86022f6f575f5))
* **docker:** ensure explicit permissions for client ssh keys generation ([f2b50df](https://github.com/snowdreamtech/openssh/commit/f2b50dfdc0f41dab96fc2734653a2c1a36c484c3))
* **docker:** explicitly add executable permissions for motd script in alpine and rocky ([1bd73f2](https://github.com/snowdreamtech/openssh/commit/1bd73f21cc8b5b8336ed57498b47f2eb72de2628))
* **docker:** remove redundant client ssh keys generation from entrypoint ([24c2b71](https://github.com/snowdreamtech/openssh/commit/24c2b71eef260edccfa2b35a855994361a0f95fd))

