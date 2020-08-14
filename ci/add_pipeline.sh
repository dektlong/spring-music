#!/usr/bin/env bash

if  [ "$1" == "" ] | [ "$2" == "" ]; then 
	echo "Incorrect usage. required: [local/remote] [PIPELINE_PARAM_FILE_NAME]"
	exit
fi

PIPELINE_PARAMS_FILE=$2

if [ "$1" == "local" ]; then
	fly -t dekt login -c http://localhost:8080 -u test -p test
fi

if [ "$1" == "remote" ]; then
	fly -t dekt login -c https://hush-house.pivotal.io/ -n field-cto -u dektlong
fi

fly -t dekt sync

fly -t dekt set-pipeline -n -p rockme -c pipeline.yml -l $PIPELINE_PARAMS_FILE