#!/bin/bash

for ((i=1; i<=10; i++))
do
  git commit --amend --no-edit
  git push -f
  sleep 360
done
