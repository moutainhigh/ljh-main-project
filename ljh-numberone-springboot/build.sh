#!/bin/sh

git pull

mvn clean package -Dmaven.test.skip=true-U