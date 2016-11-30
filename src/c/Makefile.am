## src/examples/c/Makefile.am for RLIB-TESTS

noinst_PROGRAMS = \
	example_mysql example_pg example_odbc \
	relpth1 relpth1-gen relpth2 srcpth relprt graph \
	follower follower2 \
	follower_n_to_1 follower_n_to_1_2 \
	follower_n_to_1_full_cartesian \
	follower_n_to_1_full_cartesian2 \
	follower_n_to_1_full_cartesian3 \
	follower_n_to_1_vectormatch \
	follower_n_to_1_then_1_to_1 \
	follower_1_to_1_then_n_to_1 \
	follower_circular \
	follower-breaks \
	breaks breaks2 \
	hyperinflation \
	formatstring \
	hungary

AM_CFLAGS = $(RLIB_CFLAGS) $(LIBGLIB_CFLAGS)
AM_LDFLAGS = $(RLIB_LIBS)

noinst_DATA = \
	graph.xml products.xml follower.xml follower-breaks.xml \
	breaks.xml breaks2.xml hyperinflation.xml formatstring.xml \
	hungary.xml

%.xml:
	$(LN_S) ../common-xml/$@ $@

tests: $(noinst_DATA) $(noinst_PROGRAMS)
	@$(top_srcdir)/src/scripts/runtests.sh $(abs_builddir) $(noinst_PROGRAMS)

CLEANFILES = $(noinst_DATA)
