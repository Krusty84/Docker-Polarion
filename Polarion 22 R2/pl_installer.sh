#!/bin/bash
echo -e "\nInstalling basic prerequisites..."
echo -e "\n"
echo | add-apt-repository multiverse universe universe
apt-get -y update && apt-get -y install wget mc nano curl expect
wget https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.23%2B9/OpenJDK11U-jdk_x64_linux_hotspot_11.0.23_9.tar.gz
mkdir -p /usr/lib/jvm
tar -zxf OpenJDK11U-jdk_x64_linux_hotspot_11.0.23_9.tar.gz -C /usr/lib/jvm
update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-11.0.23+9/bin/java 100 && \
update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk-11.0.23+9/bin/jar 100 && \
update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-11.0.23+9/bin/javac 100 && \
update-alternatives --set jar /usr/lib/jvm/jdk-11.0.23+9/bin/jar && \
update-alternatives --set javac /usr/lib/jvm/jdk-11.0.23+9/bin/javac && \

JAVA_HOME="/usr/lib/jvm/jdk-11.0.23+9"  # Change this path as needed
JDK_HOME="/usr/lib/jvm/jdk-11.0.23+9"   # Change this path as needed

# Ensure JAVA_HOME and JDK_HOME are correctly set in /etc/environment
# Remove existing entries if they exist
sed -i '/JAVA_HOME/d' /etc/environment
sed -i '/JDK_HOME/d' /etc/environment

# Append new JAVA_HOME and JDK_HOME values
echo "JAVA_HOME=\"$JAVA_HOME\"" | tee -a /etc/environment
echo "JDK_HOME=\"$JDK_HOME\"" |  tee -a /etc/environment

echo "JAVA_HOME and JDK_HOME have been successfully set to:"
echo "JAVA_HOME=$JAVA_HOME"
echo "JDK_HOME=$JDK_HOME"
source /etc/environment
#apt-get install -y postgresql-11
#apt-get install -y postgresql11-contrib
apt-get install -y --download-only apache2 subversion libapache2-mod-svn apache2-utils libswt-gtk-4-java
echo -e "\nInstalling Polarion..."
echo -e "\n"
sleep 5
./auto_installer.exp
sleep 5
systemctl disable polarion
systemctl enable apache2
systemctl enable postgresql-polarion