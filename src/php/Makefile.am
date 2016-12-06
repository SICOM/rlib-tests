## src/examples/php/Makefile.am for RLIB-TESTS

RLIB_TESTS = \
	array breaks csv csv-newheader example expressions fixed_part \
	flow_part flow_part_subdir \
	follower follower2 \
	follower_n_to_1_full_cartesian \
	follower_n_to_1 \
	follower_n_to_1_vectormatch \
	formatstring gantt gantt2 gantt_colors \
	graph hungary images labels multiline \
	odbc pages_across xml

noinst_DATA = \
	array.xml breaks.xml breaks2.xml csv.xml data.xml \
	expressions.xml fixed_part.xml flow_part.xml \
	follower-breaks.xml follower.xml formatstring.xml \
	formatstring2.xml gantt2.xml gantt_colors.xml \
	gantt.xml graph.xml hungary.xml hyperinflation.xml \
	images.xml labels.xml multiline.xml pages_across.xml \
	products.xml \
														\
	data.csv

%.xml:
	$(LN_S) ../common-xml/$@ $@

%.csv:
	$(LN_S) ../common-data/$@ $@

test: $(noinst_DATA) $(noinst_PROGRAMS)
	@$(top_srcdir)/src/scripts/runtests.sh $(abs_builddir) $(RLIB_TESTS)

CLEANFILES = $(noinst_DATA)
