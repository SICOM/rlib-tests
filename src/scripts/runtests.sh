#!/bin/bash

SCRIPTDIR=$(dirname $0)

TESTDIR=$1
shift

TEST=${SCRIPTDIR}/run-one-test.sh

while [ -n "$1" ]; do
	"${TEST}" "${TESTDIR}" "$1"
	shift
done

exit 0
