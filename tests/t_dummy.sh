#!/bin/sh

source funcs.sh

create_signle_dummy_dir
FILE=./sample-dicts/dummy_simple_input.txt
STANDARD=./sample-dicts/dummy_simple_output.txt
OUT=/tmp/output

convert() {
	cat $FILE | ../src/makedict -i $1 -o $2 - > $OUT

	if ! diff -u $STANDARD $OUT; then
		echo "conversation from $1 to $2 failed" >&2
		echo "FAILURE: $STANDARD $OUT is not the same" >&2
		exit 1
	fi
	rm -f $OUT
}

convert dummy dummy
convert single-dummy dummy
convert dummy single-dummy
convert single-dummy single-dummy

rm -fr "${MAKEDICT_PLUGIN_DIR}"