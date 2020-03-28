uvcvideo-5.3-mjpeg
------------------

A DKMS module for uvcvideo driver with Pavel Rojtberg's MJPEG bandwidth patch applied.

Path initially made for Logitech C615, I'm using it for Microsoft LifeCam Studio.

Original patch: https://patchwork.kernel.org/patch/9936791/

The DKMS infrastructure strongly inspired by: https://github.com/naftulikay/btusb-3.19

Building
--------

Debian pakage building uses FPM (https://github.com/jordansissel/fpm), which can be intalled with:

    apt install ruby ruby-dev rubygems build-essential
    gem install --no-ri --no-rdoc fpm

After that, hopefully, running `make` in the top-level directory should produce a nice DEB package inside build/.
The package, when installed, will register module with DKMS, and it will be rebuild automatically.

Or you can build the module directly in usr/src/uvcvideo-1.1.2 by running `make` there.

