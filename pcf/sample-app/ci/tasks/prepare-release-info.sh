#!/bin/bash

set -e

version=`cat version/version`
name="sample app ${version}"
echo "${name}" > release-info/name

pushd release-notes
  echo "$(git rev-parse HEAD)" > ../release-info/commit
popd

notes_file="release-notes/release-notes/${version}.md"
if [ ! -f $notes_file ]; then
	echo "Could not find release notes in release-notes/${notes_file}"
	exit 1
fi 
cat $notes_file > release-info/body
