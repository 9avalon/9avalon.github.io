#!/bin/sh 

simiki g
fab deploy

git add -A
git commit -am 'update'
git push -u origin master
