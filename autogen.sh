#!/bin/sh

autoreconf -vif -Wno-portability || exit $?

./configure --prefix=/usr
