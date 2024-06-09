This is a set of scripts that will allow you to containerize the excellent ALM system **[Polarion](https://polarion.plm.automation.siemens.com/en/application-lifecycle-management-alm-tool-trial)** from **[Siemens Digital Industries Software](https://www.sw.siemens.com/en-US/)**

 1. Download the contents of the Polarion 22 folder
 2. Place **PolarionALM_22_R2_linux.zip** near the **Dockerfile**
 3. Build the image: **docker build -t polarion_v22r2 .**
 4. Launch a container with Polarion: 
**docker run -d --name polarion22r2 -p 9999:80 -e ALLOWED_HOSTS="*The IP address of your Docker Engine on which the container with Polarion will be exposed*" polarion_v22r2**

*for example:* 
docker run -d --name polarion22r2 -p 9999:80 -e ALLOWED_HOSTS="192.168.249.66" polarion_v22r2
After some time you will be able to access your containerized Polarion: http://192.168.249.66:9999/polarion