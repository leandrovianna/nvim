#!/bin/sh

# Download Haskplex font on .fonts directory

git clone git@github.com:huytd/haskplex-font.git font_cache

mkdir -p ~/.fonts/
cp -r font_cache/Haskplex-Nerd ~/.fonts/
cp -r font_cache/Haskplex ~/.fonts/

rm -rf font_cache
