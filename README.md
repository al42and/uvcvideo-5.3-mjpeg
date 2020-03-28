uvcvideo-5.3-mjpeg
------------------

A DKMS module for uvcvideo driver with Pavel Rojtberg's MJPEG bandwidth patch applied.

Tested for Ubuntu 18.04.

Patch initially made for Logitech C615, I'm using it for Microsoft LifeCam Studio.

Original patch: https://patchwork.kernel.org/patch/9936791/
The DKMS infrastructure strongly inspired by: https://github.com/naftulikay/btusb-3.19

What it does
------------

Main ingredient is the  automatic USB bandwidth estimation and adjustment for MJPEG compressed video streams.
Some webcams do poor job requesting proper bandwidth, and while the fix for uncompressed video
was in the module for a while, it was not working for MJPEG-compressed streams.
The patch, proposed by Pavel Rojtberg, uses a simple conservative heuristic to estimate required USB 
bandwidth and sets it. If needed, the `mjpeg_bpp` options can be used to fine-tune it.

For some reason, this patch has not been accepted into the mainline kernel, but seems to work okay.

I also added automatic activation of `FIX_BANDWIDTH` quirk for Microsoft LifeCam Studio.

Building
--------

Debian pakage building uses FPM (https://github.com/jordansissel/fpm), which can be intalled with:

    apt install ruby ruby-dev rubygems build-essential
    gem install --no-ri --no-rdoc fpm

After that, hopefully, running `make` in the top-level directory should produce a nice DEB package inside build/.
The package, when installed, will register module with DKMS, and it will be rebuild automatically.

Once installed, it might be a reasonable next step to add the following line to `/etc/modprobe.d/uvcvideo.conf`

    options uvcvideo quirks=0x80 mjpeg_bpp=2

The `quirks` part activates `FIX_BANDWIDTH` quirk (you probably need it if you're looking for this module).
The `mjpeg_bpp` can be used to adjust bandwidth requested (in bits-per-pixel). Apparently, 1 is the average
value, 4 is the conservative default. I set it to 2, and it seems to work fine.


Or you can build the module directly in usr/src/uvcvideo-1.1.2 by running `make` there.

