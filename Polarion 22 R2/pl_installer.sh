#!/bin/bash
echo -e "\nInstalling Basic Prerequisites..."
echo -e "\n"
echo | add-apt-repository multiverse universe universe
apt-get install -y --download-only apache2 subversion libapache2-mod-svn apache2-utils libswt-gtk-4-java
wget --no-check-certificate -qO - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
    apt-get update && \
    apt-get install -y postgresql-14 postgresql-contrib-14 postgresql-client-14 && \
    apt-get clean
echo -e "\nInstalling Polarion..."
echo -e "\n"
sleep 5
./auto_installer.exp
sleep 5