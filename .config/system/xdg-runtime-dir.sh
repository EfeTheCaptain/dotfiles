#!/bin/sh

if [ ! -d /run/user/$(id -u) ]; then
  mkdir -p /run/user/$(id -u)
  chown $(id -u):$(id -g) /run/user/$(id -u)
  chmod 0700 /run/user/$(id -u)
fi
export XDG_RUNTIME_DIR=/run/user/$(id -u)
