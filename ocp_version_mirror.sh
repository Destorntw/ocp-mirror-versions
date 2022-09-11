#!/bin/bash

echo "Whats your registry containers name"
read dockerreg
podman start $dockerreg
echo "registry container should be up"
echo podman ps -a | grep $dockerreg

echo "enter desired ocp version"
read version
export OCP_RELEASE=$version

echo "enter registry name"
read registry
echo "enter registry port"
read regport
LOCAL_REGISTRY=$registry:$regport

echo "Local Repo is \'ocp4/openshift4\' "
LOCAL_REPOSITORY='ocp4/openshift4'

echo "Product Repo is \'openshift-release-dev\'"
PRODUCT_REPO='openshift-release-dev'

echo "enter path to pull secret"
read pullpath
LOCAL_SECRET_JSON=$pullpath

echo "Release Name is \'ocp-release\'"
RELEASE_NAME="ocp-release"

echo "Enter server architecture"
read arch
ARCHITECTURE=$arch

echo "enter removable media path to mirror images to"
read mediapath
REMOVABLE_MEDIA_PATH=$mediapath

echo -e "\e[36m A dry run of the download process will begin shortly"
echo "Watch out for any errors"
sleep 1s
oc adm release mirror -a ${LOCAL_SECRET_JSON} --to-dir=${REMOVABLE_MEDIA_PATH}/mirror quay.io/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_RELEASE}-${ARCHITECTURE} --dry-run

echo "Copy and paste the following command in order to begin the mirror process"

echo "oc adm release mirror -a ${LOCAL_SECRET_JSON} --to-dir=${REMOVABLE_MEDIA_PATH}/mirror quay.io/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_RELEASE}-${ARCHITECTURE}"

echo "Copy the import command that was prompted to you at the end of the mirror process"
