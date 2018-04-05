#!/usr/bin/env bash

# This is a shell script to transform the PRODUCTNAME directory into a cookie-cutter template

set -e
set -o pipefail

# Run this script in its own directory
SCRIPT_DIR="$(dirname $0)"
cd $SCRIPT_DIR

echo "Regenerating cookiecutter template from PRODUCTNAME directory contents..."

#This is the only lookup that is done on filenames
LOOKUP="PRODUCTNAME"
EXPANDED="{{ cookiecutter.project_name | replace(' ', '') }}"

# Clear out any left over artifacts from last regeneration
rm -rf "${EXPANDED}/"

# Make the tree
find ./PRODUCTNAME -type d | while read FILE
do
    NEWFILE=`echo $FILE | sed -e "s/${LOOKUP}/${EXPANDED}/g"`
    if [ "${VERBOSE}" == "true" ] ; then
        echo "mkdir -p \"$NEWFILE\""
    fi
    mkdir -p "$NEWFILE"
done

# Copy the files over
find ./PRODUCTNAME -type f | while read FILE
do
    NEWFILE=`echo $FILE | sed -e "s/${LOOKUP}/${EXPANDED}/g"`
    if [ "${VERBOSE}" == "true" ] ; then
        echo "cp \"$FILE\" \"$NEWFILE\""
    fi
    cp "$FILE" "$NEWFILE"
done

# Do replacements
function replace {
    grep -rl $1 ./PRODUCTNAME | while read FILE
    do 
    NEWFILE=`echo $FILE | sed -e "s/${LOOKUP}/${EXPANDED}/g"`
        # Copy over incase the sed fails due to encoding
        #echo "echo \"$FILE\""
        if [ "${VERBOSE}" == "true" ] ; then
            echo "sed -e \"s/$1/$2/g\" \"$NEWFILE\" > t1 && mv t1 \"$NEWFILE\""
        fi
        sed -e "s/$1/$2/g" "$NEWFILE" > t1 && mv t1 "$NEWFILE"
    done
}

replace "PRODUCTNAME" "{{ cookiecutter.project_name | replace(' ', '') }}"
replace "ORGANIZATION" "{{ cookiecutter.company_name }}"
replace "LEADDEVELOPER" "{{ cookiecutter.lead_dev }}"
replace "LEADEMAIL" "{{ cookiecutter.lead_email }}"
replace "com.raizlabs.PRODUCTNAME" "{{ cookiecutter.bundle_identifier }}"

# Delete files that we don't want to include in the template
rm -rf "${EXPANDED}/app/Podfile.lock"
rm -rf "${EXPANDED}/app/Pods"
rm -rf "${EXPANDED}/app/${EXPANDED}.xcworkspace"

echo "Template generation complete."

# Run Tests

if [ "${SKIP_TESTS}" == "true" ] ; then
    echo "Skipping tests..."
    exit 0
fi

echo "Running tests..."

# cookiecutter default output dir is ProjectName
TEST_OUTPUT_DIR="ProjectName"
cookiecutter --no-input --overwrite-if-exists ./
pushd "$TEST_OUTPUT_DIR/app"
    bundle install
    bundle exec fastlane test
popd

rm -rf "${TEST_OUTPUT_DIR}"

echo "Tests complete."