#Download the windows image
FROM microsoft/windowsservercore:10.0.14393.2068

#ensure the rights are intact to install the required tools
RUN powershell -Command Set-ExecutionPolicy AllSigned
RUN powershell -Command et-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#install java
RUN powershell choco install jdk8
#RUN powershell choco install openjdk11

#install Tomcat
RUN powershell choco install tomcat

#Allow tomcat to access its associated folders and files
RUN powershell icacls "C:\\programdata\\tomcat9" /grant everyone:F /T

#copy the context xml file to tomcat path
COPY \build\context.xml C:\programdata\tomcat9\conf
COPY \build\context.xml C:\programdata\tomcat9\webapps\manager\META-INF
COPY \build\context.xml C:\programdata\tomcat9\webapps\host-manager\META-INF

