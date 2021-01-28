#!/bin/bash
PROTO_OUT_FILE="./protos/protos.proto"
LIB_OUT_DIR="./lib/gen"

if [ -f "$PROTO_OUT_FILE" ]; then
  echo "Deleting old $PROTO_OUT_FILE"
  rm "$PROTO_OUT_FILE";
fi

cat << HEADER > "$PROTO_OUT_FILE"
// AUTO GENERATED FILE, DO NOT EDIT!
//
// Generated by $0

syntax = "proto3";
option java_package = "de.mintware.barcode_scan";
HEADER

echo $FILE_HEADER >> $PROTO_OUT_FILE;

for f in protos/*.proto; do
  if [ "./$f" = $PROTO_OUT_FILE ]; then
    continue ;
  fi;
  echo "Adding $f";
  (
    echo "// $f";
    ## Remove duplicate headers
    cat $f | sed -E 's#^(syntax|package|option|import).+$##' | sed  '/^$/d';
    echo ''
  ) >> $PROTO_OUT_FILE;
done

echo "Generating in $LIB_OUT_DIR"

protoc \
--dart_out="$LIB_OUT_DIR" \
"$PROTO_OUT_FILE"

