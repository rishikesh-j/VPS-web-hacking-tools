#!/bin/bash -i
#Check if the script is executed with root privileges
if [ "$EUID" -ne 0 ]
  then echo -e ${RED}"Please execute this script with root privileges !"
  exit
fi

#Creating tools directory if not exist
source ./.env && mkdir -p $TOOLS_DIRECTORY;
clear;

ENVIRONMENT () {
	echo -e ${BLUE}"[ENVIRONMENT]" ${RED}"Packages required installation in progress ...";
	#Check Operating System
	OS=$(lsb_release -i 2> /dev/null | sed 's/:\t/:/' | cut -d ':' -f 2-)
	if [ "$OS" == "Debian" ] || [ "$OS" == "Linuxmint" ]; then
		#Specific Debian
		#chromium
		apt-get update -y > /dev/null 2>&1;
		apt-get install chromium python python3 python3-pip unzip make gcc libpcap-dev curl build-essential libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev ruby libgmp-dev zlib1g-dev -y > /dev/null 2>&1;
		cd /tmp && curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py > /dev/null 2>&1 && python2 get-pip.py > /dev/null 2>&1;
	elif [ "$OS" == "Ubuntu" ]; then
		#Specific Ubuntu
		#Specificity : chromium-browser replace chromium
        apt-get update -y > /dev/null 2>&1
        apt-get install chromium-browser python python3 python3-pip unzip make gcc libpcap-dev curl build-essential libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev ruby libgmp-dev zlib1g-dev -y > /dev/null 2>&1;
        cd /tmp && curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py > /dev/null 2>&1 && python2 get-pip.py > /dev/null 2>&1;
	elif [ "$OS" == "Kali" ]; then
		#Specific Kali Linux
		#Specificity : no package name with "python"
        apt-get update -y > /dev/null 2>&1;
        apt-get install chromium python3 python3-pip unzip make gcc libpcap-dev curl build-essential libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev ruby libgmp-dev zlib1g-dev -y > /dev/null 2>&1;
        cd /tmp && curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py > /dev/null 2>&1 && python2 get-pip.py > /dev/null 2>&1;
        pip install -U setuptools > /dev/null 2>&1;
        #Needed for NoSQLMap
        pip install couchdb pbkdf2 pymongo ipcalc > /dev/null 2>&1;    
	else
        echo "OS unrecognized. Please check the compatibility with your system.";
        echo "End of the script";
        exit;
	fi
unset OS
	#Bash colors
	sed -i '/^#.*force_color_prompt/s/^#//' ~/.bashrc && source ~/.bashrc
	echo -e ${BLUE}"[ENVIRONMENT]" ${GREEN}"Packages required installation is done !"; echo "";
	#Generic fot both OS - Golang environment
	echo -e ${BLUE}"[ENVIRONMENT]" ${RED}"Golang environment installation in progress ...";
	cd ~; wget https://go.dev/dl/go1.19.2.linux-amd64.tar.gz > /dev/null 2>&1 && rm -rf /usr/local/go && tar -C /usr/local -xzf go1.19.2.linux-amd64.tar.gz > /dev/null 2>&1 && echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc; source .bashrc; rm -r go1.19.2.linux-amd64.tar.gz
	echo -e ${BLUE}"[ENVIRONMENT]" ${GREEN}"Golang environment installation is done !"; echo "";
}
