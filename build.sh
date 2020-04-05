#!/bin/sh

IMAGE_NAME=oci-oke-cli
IMAGE_TAG=0.2.0

REPOSITORY_ID=$IMAGE_NAME:$IMAGE_TAG

if [ -z $1 ];
then
	REPOSITORY_ID=$IMAGE_NAME:$IMAGE_TAG
else
	REPOSITORY_ID=$1/$IMAGE_NAME:$IMAGE_TAG
fi

docker build --build-arg BUILD_DATE=`date -u +”%Y-%m-%dT%H:%M:%SZ”` \
             --build-arg VCS_REF=`git rev-parse --short HEAD` \
             --build-arg VERSION=$IMAGE_TAG \
             -t $REPOSITORY_ID .
