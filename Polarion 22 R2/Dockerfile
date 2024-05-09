FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /tmp
COPY PolarionALM_22_R2_linux.zip ./
COPY pl_start.sh ./
COPY pl_installer.sh ./
COPY auto_installer.exp ./
RUN chmod +x pl_start.sh && \
	chmod +x pl_installer.sh && \
	chmod +x auto_installer.exp && \
	unzip PolarionALM_22_R2_linux.zip
RUN apt-get -y update && \
    apt-get -y install wget mc nano curl expect apache2 subversion libapache2-mod-svn apache2-utils libswt-gtk-4-java

RUN wget https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.23%2B9/OpenJDK11U-jdk_x64_linux_hotspot_11.0.23_9.tar.gz && \
    mkdir -p /usr/lib/jvm && \
    tar -zxf OpenJDK11U-jdk_x64_linux_hotspot_11.0.23_9.tar.gz -C /usr/lib/jvm

RUN update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-11.0.23+9/bin/java 100 && \
    update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk-11.0.23+9/bin/jar 100 && \
    update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-11.0.23+9/bin/javac 100 && \
    update-alternatives --set jar /usr/lib/jvm/jdk-11.0.23+9/bin/jar && \
    update-alternatives --set javac /usr/lib/jvm/jdk-11.0.23+9/bin/javac

ENV JAVA_HOME="/usr/lib/jvm/jdk-11.0.23+9" \
    JDK_HOME="/usr/lib/jvm/jdk-11.0.23+9"

RUN echo "JAVA_HOME=\"$JAVA_HOME\"" >> /etc/environment && \
    echo "JDK_HOME=\"$JDK_HOME\"" >> /etc/environment

RUN echo "JAVA_HOME and JDK_HOME have been successfully set to:" && \
    echo "JAVA_HOME=$JAVA_HOME" && \
    echo "JDK_HOME=$JDK_HOME"
	
RUN /auto_installer.exp

ENTRYPOINT ["/pl_start.sh"]

#docker run -d --name polarion-container -e ALLOWED_HOSTS="localhost,192.168.0.1,srv_pl" polarion22image
