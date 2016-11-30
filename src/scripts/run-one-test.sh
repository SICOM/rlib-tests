#!/bin/bash
#
# This script is for running regression tests
# It expects a file called something.test when it is called

DIR="$1"
FILE="$2"

bold=$(tput bold)
normal=$(tput sgr0)

if [ ! -f "${DIR}/${FILE}.test" ]; then
	echo "${DIR}/${FILE}.test ${bold}DOES NOT EXIST${normal}"
	exit 1
fi

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
done

exit 0
