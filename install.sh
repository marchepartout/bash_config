#!/usr/bin/env bash

SCRIPT_DIR=$(dirname $(readlink -f "$0"))
SCRIPT_NAME=$(basename "$0")

INSTALL_DIR=${1-$HOME}
echo "Install into directory: ${INSTALL_DIR}"

pushd ${SCRIPT_DIR}
cp -rf --no-target-directory ${SCRIPT_DIR} ${INSTALL_DIR}
rm -rf ${INSTALL_DIR}/.git ${INSTALL_DIR}/${SCRIPT_NAME}
popd

echo 'To finalize the install, run the following command:'
echo "source ${INSTALL_DIR}/.bash_profile"

