# Copyright (c) 2016 SICOM Systems Inc (bdoan@sicompos.com)

ACLOCAL_AMFLAGS = -I m4

SUBDIRS = src

test:
	$(MAKE) -C src $@

test-c:
	$(MAKE) -C src $@

test-php:
	$(MAKE) -C src $@

test: test-c test-php
