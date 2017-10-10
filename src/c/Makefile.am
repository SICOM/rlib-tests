## src/examples/c/Makefile.am for RLIB-TESTS

noinst_PROGRAMS =
EXTRA_TESTS = example_mysql_gen
EXTRA_XML =

if TEST_C_ARRAY_DATASOURCE

noinst_PROGRAMS += \
	example_mysql example_pg example_odbc \
	relpth1 relpth2 relpth3 $(SEARCH_PATH_TESTS) \
	$(ARRAY_DATASOURCE_TESTS)

ARRAY_DATASOURCE_TESTS = \
	breaks breaks2 \
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
	formatstring graph \
	hungary hungary2 russian \
	hyperinflation

endif

SEARCH_PATH_TESTS =

if TEST_SEARCH_PATH
if TEST_C_ARRAY_DATASOURCE
SEARCH_PATH_TESTS += relprt relpth1-gen srcpth
EXTRA_TESTS += relprt-noquery
else
SEARCH_PATH_TESTS += relpth1-gen srcpth
endif
endif

if MSGFMT_FOUND

TRANSLATEMO = locale/en_US/LC_MESSAGES/translate.mo

$(TRANSLATEMO): $(top_srcdir)/src/common-data/translate.po
	$(MSGFMT) -o $@ $<

translate_DEPENDENCIES: $(TRANSLATEMO)

noinst_PROGRAMS += translate
EXTRA_TESTS += translate
EXTRA_XML += translate.xml

endif

RLIB_TESTS = $(noinst_PROGRAMS) $(EXTRA_TESTS)

AM_CFLAGS = $(RLIB_CFLAGS) $(LIBGLIB_CFLAGS)
AM_LDFLAGS = $(RLIB_LIBS)

noinst_DATA = \
	graph.xml products.xml follower.xml follower-breaks.xml \
	follower-3data.xml breaks.xml breaks2.xml hyperinflation.xml \
	formatstring.xml hungary.xml hungary2.xml russian.xml \
	$(EXTRA_XML) $(TRANSLATEMO)

%.xml:
	$(LN_S) ../common-xml/$@ $@

test: $(noinst_DATA) $(noinst_PROGRAMS)
	@echo
	@echo Running C test cases
	@echo
	@$(top_srcdir)/src/scripts/runtests.sh $(abs_builddir) $(RLIB_TESTS)

CLEANFILES = $(noinst_DATA) $(TRANSLATEMO)
