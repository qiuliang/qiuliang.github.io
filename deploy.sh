#!bin/bash

categories=${1}

cp -rf ./_site/index.html ../qiuliang.github.io/
cp -rf ./_site/archives.html ../qiuliang.github.io/
cp -rf ./_site/images ../qiuliang.github.io/

cp -rf ./_site/page2 ../qiuliang.github.io/
cp -rf ./_site/page3 ../qiuliang.github.io/
cp -rf ./_site/page4 ../qiuliang.github.io/
cp -rf ./_site/page5 ../qiuliang.github.io/

cp -rf ./_site/$categories ../qiuliang.github.io/

echo success