#!/bin/bash
set -e

PUBSPEC_PATH=$1
INCREMENT="true"
if [ ! -z $2 ]; then
    INCREMENT=$2
fi

VERSION_REGEX=".*version: ([0-9]*\.[0-9]*\.)([0-9]*)\+([0-9]*)"
VERSION_PART1=""
VERSION_PART2=""
VERSION_CODE=""

if [ -z "$PUBSPEC_PATH" ]; then
    echo "You need to specify an argument for the file to incremeent the number for"
    exit -1
fi

if [ ! -f "$PUBSPEC_PATH" ]; then
    echo "The given file does not exist"
    exit -1
fi

VERSION_LINE=$(grep "version: " "$PUBSPEC_PATH")
if [[ "$VERSION_LINE" =~ $VERSION_REGEX ]]; then
    VERSION_PART1="${BASH_REMATCH[1]}"
    VERSION_PART2="${BASH_REMATCH[2]}"
    VERSION_CODE="${BASH_REMATCH[3]}"
else
    echo "An error occurred while trying to get the version number, the regex didn't match anything"
    exit 1
fi

if [ $INCREMENT != 'true' ]; then
    echo "${VERSION_PART1}${VERSION_PART2}+${VERSION_CODE}"
    exit 0
fi

VERSION_CODE_UPD=$(($VERSION_CODE + 1))
MINOR_UPDATE=$(($VERSION_PART2 + 1))

NEXT_VERSION="$VERSION_PART1$MINOR_UPDATE+$VERSION_CODE_UPD"

# Replace the current version number
TMP_FILE="$PUBSPEC_PATH-tmp.yaml"
OLD_VERSION="${VERSION_PART1}${VERSION_PART2}+${VERSION_CODE}"
sed "s/version: $OLD_VERSION/version: $NEXT_VERSION/" "$PUBSPEC_PATH" > "$TMP_FILE"
mv "$TMP_FILE" "$PUBSPEC_PATH"

echo "${VERSION_PART1}${MINOR_UPDATE}+${VERSION_CODE_UPD}"
