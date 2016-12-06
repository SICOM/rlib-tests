#!/bin/bash
#
# This script is for running one regression test.
#
# $1 is the directory where it should be running from
# $2 is the test name
#
# It also expects a file called testname.test when it is called
# which is a shell script file with the environment variables
# described below.
#
# COMMAND="command"
#   The command to run for the test.
#	The command must accept the output format in text
#	as the last argument. See "FORMATS" below.
# EXTRA_COMMAND="extra_command"
#	Extra command to run after the test has run
#	and the result is compared with the expected output(s).
#	Can be used to clean up supplementary output files,
#	like PNGs created for the HTML output.
# FORMATS="pdf xml txt csv html"
#	All the formats that the test supports.
#	Some tests may only need "txt" when certain
#	error cases are tested. It is the "testname.txt.stderr"
#	that's interested in this case.
#	Only "pdf", "xml", "txt", "csv" and "html" are accepted
#	in the FORMATS variable as a space separated list.
#	Any other word is still passed in as-is to the test
#	but it may fail and it is not handled in the settings below.
# EXPECTED_pdf=
# EXPECTED_xml=
# EXPECTED_txt=
# EXPECTED_csv=
# EXPECTED_html=
#	When there are multiple accepted outcomes for a specific
#	output format, these are listed in these variables. E.g. "1 2".
#	These values are appended to the expected output name
#	to compare with. These files may exist in the "expected"
#	directory:
#
#	testname.format.stderr1
#	testname.format.stderr2
#	testname.format.stdout1
#	testname.format.stdout2
#
#	These will be compared to the current result and if
#	one of them matches, the result is accepted.
#	If one of this variable
#
# Any extra variables added to the testname.test file
# may also be picked up by the test case.
#

if [ -z "$2" ]; then
	exit 1
fi

DIR="$1"
FILE="$2"

bold=$(tput bold)
normal=$(tput sgr0)

if [ ! -f "${DIR}/${FILE}.test" ]; then
	echo "${DIR}/${FILE}.test ${bold}DOES NOT EXIST${normal}"
	exit 1
fi

EXTRA_COMMAND=

. $DIR/$FILE.test

runtest1 () {
	EXP_FILE="${DIR}/expected/${FILE}.${FORMAT}.stdout${exp}"
	if [ ! -f "$EXP_FILE" ]; then
		EXP_FILE="/dev/null"
	fi
	diff -au ${EXP_FILE} ${DIR}/results/${FILE}.${FORMAT}.stdout >${DIR}/results/${FILE}.${FORMAT}.stdout.diff
	WC1=$(cat ${DIR}/results/${FILE}.${FORMAT}.stdout.diff | wc -l)

	EXP_FILE="${DIR}/expected/${FILE}.${FORMAT}.stderr${exp}"
	if [ ! -f "$EXP_FILE" ]; then
		EXP_FILE="/dev/null"
	fi
	diff -au ${EXP_FILE} ${DIR}/results/${FILE}.${FORMAT}.stderr >${DIR}/results/${FILE}.${FORMAT}.stderr.diff
	WC2=$(cat ${DIR}/results/${FILE}.${FORMAT}.stderr.diff | wc -l)

	if [ "$WC1" = "0" ]; then
		rm -f ${DIR}/results/${FILE}.${FORMAT}.stdout.diff

		if [ "$WC2" = "0" ]; then
			rm -f ${DIR}/results/${FILE}.${FORMAT}.stderr.diff
			ERROR=0
		else
			ERROR=1
		fi
	else
		ERROR=1
	fi
}

export RPDF_DEBUGGING=1
export RLIB_DEBUGGING=1

for FORMAT in $FORMATS ; do
	${COMMAND} $FORMAT >"${DIR}/results/${FILE}.${FORMAT}.stdout" 2>"${DIR}/results/${FILE}.${FORMAT}.stderr"

	# Support multiple expected outputs for every formats
	case $FORMAT in
	pdf)
		EXPECTED=$EXPECTED_pdf
		;;
	xml)
		EXPECTED=$EXPECTED_xml
		;;
	txt)
		EXPECTED=$EXPECTED_txt
		;;
	csv)
		EXPECTED=$EXPECTED_csv
		;;
	html)
		EXPECTED=$EXPECTED_html
		;;
	*)
		EXPECTED=
		;;
	esac

	ERROR=1
	if [ -z "$EXPECTED" ]; then
		exp=""
		runtest1
	else
		for exp in $EXPECTED ; do
			runtest1
			if [ "$ERROR" = "0" ]; then
				break
			fi
		done
	fi

	if [ "$ERROR" = "0" ]; then
		echo $FILE $FORMAT ${bold}OK${normal}
	else
		echo $FILE $FORMAT ${bold}FAILED${normal}
		echo ${bold}Check these files:${normal}
		echo "${DIR}/results/${FILE}.${FORMAT}.stdout"
		echo "${DIR}/results/${FILE}.${FORMAT}.stderr"
	fi

	if [ -n "$EXTRA_COMMAND" ]; then
		$EXTRA_COMMAND
	fi
done

exit 0
