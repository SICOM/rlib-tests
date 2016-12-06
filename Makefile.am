# Copyright (c) 2016 SICOM Systems Inc (bdoan@sicompos.com)

ACLOCAL_AMFLAGS = -I m4

SUBDIRS = src

test-c: all
	@echo
	@echo Running C test cases
	@echo
	$(MAKE) -C src/c test

test-php: all
	@echo
	@echo Running PHP test cases
	@echo
	$(MAKE) -C src/php test

test: test-c test-php
