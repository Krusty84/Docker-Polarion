FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
ENV RUNLEVEL 1
RUN apt-get -y update && \
    apt-get -y install sudo unzip expect curl wget mc nano iputils-ping net-tools iproute2 gnupg software-properties-common locales && locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
WORKDIR /polarion_root
COPY PolarionALM_22_R2_linux.zip ./
RUN unzip PolarionALM_22_R2_linux.zip
COPY pl_starter.sh ./
COPY pl_installer.sh ./Polarion
COPY auto_installer.exp ./Polarion
RUN chmod +x pl_starter.sh && \
	chmod +x ./Polarion/pl_installer.sh && \
	chmod +x ./Polarion/auto_installer.exp
RUN wget --no-check-certificate https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.23%2B9/OpenJDK11U-jdk_x64_linux_hotspot_11.0.23_9.tar.gz && \
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
WORKDIR /polarion_root/Polarion
RUN printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d
RUN sed -i "s/^exit 101$/exit 0/" /usr/sbin/policy-rc.d
RUN ./pl_installer.sh
WORKDIR /polarion_root
ENV PATH="/usr/lib/postgresql/14/bin:${PATH}"
ENTRYPOINT ["./pl_starter.sh"]
