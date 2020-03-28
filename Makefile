#!/usr/bin/make -f

PKG_NAME=uvcvideo-5.3-mjpeg-dkms
PKG_VERSION=1.0.0
PKG_DESCRIPTION="Backported Bluetooth module from kernel 4.2 including new MacBook hardware support."

MAINTAINER="Andrey Alekseenko <al42and@gmail.com>"
VENDOR="al42and"
HOMEPAGE="https://github.com/al42and/uvcvideo-5.3-mjpeg"
HEADER_PACKAGE="linux-headers-generic-hwe-18.04"

all:
	test -d build || mkdir build
	fpm -f -s dir -t deb -n $(PKG_NAME) -v $(PKG_VERSION) -a all -p build/ \
		-d dkms -d build-essential -d $(HEADER_PACKAGE) \
		-m $(MAINTAINER) --vendor $(VENDOR) --license GPLv2 --description $(PKG_DESCRIPTION) \
		--url $(HOMEPAGE) --deb-changelog CHANGELOG \
		--post-install scripts/post-install.sh --pre-uninstall scripts/pre-uninstall.sh \
		--exclude '.git*' usr/
