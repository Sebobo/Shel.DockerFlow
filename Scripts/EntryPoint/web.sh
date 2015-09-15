#!/bin/bash

# Exit with error if a command returns a non-zero status
set -e

WEB_HOST_IP=`grep -i web /etc/hosts | head -n 1 |  awk '{print $1}'`
echo "${WEB_HOST_IP}	${PROJECT_NAME}" > /ip_address.txt
echo "${WEB_HOST_IP}	test.${PROJECT_NAME}" >> /ip_address.txt
