#!/usr/bin/env bash
set -e

# Name of application to install
echo ""
echo -e "\e[1;34mChecking dependencies for bulkRNASeqPIPE installation ...\e[0m"
echo ""

sleep 2s;
#Check Ubuntu
if [ -f /etc/lsb-release ]; then
    declare -a dpkglist=("git-all" "zlib1g-dev" "gcc" "cpp")
    for package in "${dpkglist[@]}";
            do
                    if [ $(dpkg-query -W -f='${Status}' $package 2>/dev/null | grep -c "ok installed") -eq 1 ];
                            then
                            echo -e "\e[1;36m $package \t...installed \e[0m";
                    else
                            echo -e "\e[1;31m install $package using \"sudo apt-get install $package\" \e[0m";
                    fi
            done
fi

if [ -f /etc/lsb-release ]; then
    declare -a dpkglist=("git-all" "zlib1g-dev" "gcc" "cpp")
    for package in "${dpkglist[@]}";
            do
                    if ! [ $(dpkg-query -W -f='${Status}' $package 2>/dev/null | grep -c "ok installed") -eq 1 ];
                            then
                            exit 0
                    fi
            done
fi


if [ -f /etc/redhat-release ]; then
    declare -a dpkglist=("git" "zlib-devel" "gcc" "gcc-c++")
    for package in "${dpkglist[@]}";
            do
                    if [ $(rpm -qa | grep $package 2>/dev/null | grep -c $package) -ge 1 ] ;
                            then
                            echo -e "\e[1;36m $package \t...installed \e[0m";
                    else
                            echo -e "\e[1;31m install $package using \"sudo yum install $package\" \e[0m";
                    fi
            done
fi

if [ -f /etc/redhat-release ]; then
    declare -a dpkglist=("git" "zlib-devel" "gcc" "gcc-c++")
    for package in "${dpkglist[@]}";
            do
                    if ! [ $(rpm -qa | grep $package 2>/dev/null | grep -c $package) -ge 1 ] ;
                            then
                            exit 0
                    fi
            done
fi
