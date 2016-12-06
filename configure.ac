dnl Configure template for RLIB regression tests

dnl Copyright (c) 2016 SICOM Systems Inc (bdoan@sicompos.com)
dnl RLIB-TESTS is free software; you can redistribute it and/or modify
dnl it under the terms of the MIT License.
dnl
dnl You can base your own reports on these examples.

dnl Report bugs to rlib-devel@lists.sourceforge.net
dnl
dnl Process this file with autoconf to produce a configure script.

AC_INIT([rlib-tests],[0.0.1],[http://bugzilla.sicompos.com])
AC_CANONICAL_TARGET
AC_CONFIG_SRCDIR(Makefile.am)
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_AUX_DIR(.)

AM_INIT_AUTOMAKE()
AC_CONFIG_HEADERS(config.h)
AM_MAINTAINER_MODE

AC_PROG_CC
AM_PROG_CC_C_O
AC_PROG_INSTALL
AC_PROG_MAKE_SET
AC_PROG_LN_S

PKG_CHECK_MODULES(LIBGLIB, glib-2.0)
AC_SUBST(LIBGLIB_LIBS)
AC_SUBST(LIBGLIB_CFLAGS)

PKG_CHECK_MODULES(RLIB, rlib)
AC_SUBST(RLIB_LIBS)
AC_SUBST(RLIB_CFLAGS)

CFLAGS="-D_GNU_SOURCE -Wall -Wextra -Werror $CFLAGS"

AC_CONFIG_FILES([
Makefile
src/Makefile
src/c/Makefile
src/php/Makefile
])

AC_OUTPUT
