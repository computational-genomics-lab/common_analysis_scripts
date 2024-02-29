#!/usr/bin/env bash
set -e

# Name of application to install

echo ""
echo -e "\e[1;34mChecking dependencies for bulkRNASeqPIPE installation ...\e[0m"
echo ""

sleep 2s;
#Check Ubuntu
if [ -f /etc/lsb-release ]; then
    declare -a dpkglist=("libssl-dev" "libcurl4-openssl-dev" "libxml2-dev" "libboost-all-dev" "libbz2-dev" "liblzma-dev")
    for package in "${dpkglist[@]}";
            do
                    if [ $(dpkg-query -W -f='${Status}' $package 2>/dev/null | grep -c "ok installed") -eq 1 ];
                            then
                            echo -e "\e[1;36m $package \t...installed \e[0m";
                    else
                            echo -e "\e[1;31m install $package manually using \"sudo apt-get install package-name\" The installer will auto exit now\e[0m";
                            sleep 5s;
                            exit 0
                    fi
            done
fi

if [ -f /etc/redhat-release ]; then
    declare -a dpkglist=("libcurl" "openssl-devel")
    for package in "${dpkglist[@]}";
            do
                    if rpm -qa | grep $package;
                            then
                            echo -e "\e[1;36m $package \t...installed \e[0m";
                    else
                            echo -e "\e[1;31m install $package manually using \"sudo yum install package-name\" The installer will auto exit now\e[0m";
                            sleep 5s;
                            exit 0
                    fi
            done
fi
