#!/bin/bash
set -ex
stack ghc -- --make site
if ! [ -z "$1" ]; then
  ./site "$@";
else
  ./site watch --host=0.0.0.0
fi
