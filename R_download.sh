#this bash script sets the URL for downloading R programming language core package based on the version of Ubuntu detected on the system\

R_VERSION=3.6.1
release=$(lsb_release -a | tail -n 1 | cut -f2)
if [ "$release" == "xenial" ];
   then R_DOWNLOAD_URL="https://cloud.r-project.org/bin/linux/ubuntu/xenial-cran35/r-base-core_${R_VERSION}-3xenial_amd64.deb"
   echo -e "\e[1;31m $R_DOWNLOAD_URL \e[0m";
fi

if [ "$release" == "trusty" ];
   then R_DOWNLOAD_URL="https://cloud.r-project.org/bin/linux/ubuntu/trusty-cran35/r-base-core_${R_VERSION}-3trusty2_amd64.deb"
   echo -e "\e[1;31m $R_DOWNLOAD_URL \e[0m";
fi

if [ "$release" == "bionic" ];
   then R_DOWNLOAD_URL="https://cloud.r-project.org/bin/linux/ubuntu/bionic-cran35/r-base-core_${R_VERSION}-3bionic_amd64.deb"
   echo -e "\e[1;31m $R_DOWNLOAD_URL \e[0m";
fi
