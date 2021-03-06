#!/bin/sh
set -e

export VSINSTALLDIR="C:\Program Files (x86)\Microsoft Visual Studio\2017\Community"
export VisualStudioVersion="15.0"

C:/tools/docfx/docfx ./docfx.json --force

SOURCE_DIR=$PWD
TEMP_REPO_DIR=$PWD/docs-gh-pages

echo "Removing temporary doc directory $TEMP_REPO_DIR"
rm -rf $TEMP_REPO_DIR
mkdir $TEMP_REPO_DIR

echo "Cloning the gh-pages org repo with the master branch"
git clone https://github.com/DataSpreads/DataSpreads.github.io.git --branch master $TEMP_REPO_DIR

echo "Clear repo directory"
cd $TEMP_REPO_DIR
git rm -r *
echo 'docs.dataspreads.io' > CNAME

echo "Copy documentation into the repo"
cp -r $SOURCE_DIR/_site/* .

echo "Push the new docs to the remote branch"
git add . -A
git commit -m "Update generated documentation"
git push origin master