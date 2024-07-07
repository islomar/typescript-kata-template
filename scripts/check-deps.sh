#!/bin/bash

. scripts/helpers/colors.sh

IS_DOCKER_INSTALLED=$(command -v docker)

if [ $? -ne 0 ]; then
    echo "${bakred}Docker is not available. Please install Docker${txtrst}\n\n"
else
    echo "${txtblk}${bakgrn}Nice! You have everything needed${txtrst}"
fi
