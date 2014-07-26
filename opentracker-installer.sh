#!/bin/bash



####################################################################################################
#	OpenTracker Aut-Installer v0.1								   #
#	Support:admin@yify-torrents.com								   #
#												   #
#	This script is a free tool which automatically installs OpenTracker 			   #
# 	for BitTorrent.										   #
#												   #				
#												   #
#	For more information about OpenTracker go to:						   #
#				http://erdgeist.org/arts/software/opentracker/			   #
#												   #			
#												   #
#	Enjoy this easy to use tool which make life that little bit easier			   #
#	This program is distributed in the hope that it will be useful				   #
#												   #			
#												   #
#		               Written By: YIFY @ http://yify-torrents.com		 	   #
# 												   #			
#												   #
#    	How to instal using this script(run the following commands:				   #
#	chmod 755 opentracker-installer.sh							   #
#	./opentracker-installer.sh								   #
#												   #
#	Follow the settings input and you are all done :)					   #	
#												   #
####################################################################################################
####################################################################################################
#################################################Nyo################################################
###############################################Ny:---o##############################################
#############################################Ns:------:o############################################
###########################################Ns:----------:o##########################################
#########################################Ns:--------------:o########################################
#######################################Ns:-------------------+######################################
#####################################Ns:---..`````` ```````.---+####################################
###################################Ns:---.                    `--+d#################################
#################################Ns:----`                      `---+d###############################
###############################Ns:-----`        ``` `           -----+d#############################
#############################Ns:------.       -----------       .------+d###########################
###########################Ns:--------.       ------------`      --------+d#########################
#########################Ns:-----------      `---------------.-------------+d#######################
#######################Ns:------------.      .-------------------------------+d#####################
######################s:--------------`      `------------.``  ----------------+d###################
####################o:----------------`      `-----------`     `-----------------+d#################
##################o:------------------.       `--------.        .------------------+d###############
################o:---------------------                         .--------------------+d#############
##############o:------------------------`                      ------------------------/d###########
############o:----------------------------`                 `.---------------------------/d#########
##########o:-----------------------------------....---....---------------------------------/h#######
########h++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++sN#####
####################################################################################################
#                                                                                                  #
#        -://://:.      `.-----.       .`-.--.-.      -:      `:/   `-..-.`.---`      `------`     #
#       /:.`````:+`    -+:..---/+.    -+:---:-:+/     `+/     /+.   -+/.-:+/.--+/    //.....-/+.   #
#      `+-       .`    +:       +:    .+       -+.     .+:   -+.    -+.  `+:   +/   `+`      `+.   #
#      `+.            `+/       /-    :+`      .+.      .+. :+`     -+`  `+-   +/   `+::-//+/:/`   #
#      `+:      ./`    +/      `+-    -+`      -+`       -+:+:      -+`   +-   +/   `+`       -    #
#       -+/::-:/+/     -+:-----++.    -+/-..-.-+/`        -+-       .+.  -+:  `+:   `/:..`.--//    #
#          `````         .....-`      ./.......`         :+:        `.    -.   -`     `....-..     #
#                                     -+.             `-/+:                                        #
#                                     -+`              --`                                         #
#                                                                                                  #
####################################################################################################




# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script"
    exit 1
fi

clear
echo "=================================================================="
echo "OpenTracker auto-installer                                By: YIFY"
echo "=================================================================="
echo "This will auto-compile and install OpenTracker BitTorrent Tracker "
echo ""
echo "Brought to you by YIFY       @       http://www.yify-torrents.com/"
echo "=================================================================="
echo ""

read -n 1 -p "Press any key to start..."


clear
#Set main variables

echo "Example of tracker url layout and port:"
echo ""
echo "--------------------------------------------------------------"
echo -e "| http://tracker.domain.com/announce       port \033[38;5;148m80   [TCP]\033[39m  |"
echo -e "| http://tracker.domain.com:80/announce    port \033[38;5;148m80   [TCP]\033[39m  |"
echo -e "| http://tracker.domain.com:6969/announce  port \033[38;5;148m6969 [TCP]\033[39m  |"
echo -e "| udp://tracker.domain.com:1337/announce   port \033[38;5;148m1337 [UDP]\033[39m  |"
echo "--------------------------------------------------------------"
echo ""
echo "==========================="
echo ""
echo -e "\033[38;5;148mPlease choose a port number for OpenTracker:\033[39m"
read -p "(Default port is 6969):" port

#check if a cutom port was entered
if [ "$port" = "" ]; then
	port=6969
fi
echo ""
netstat -ln  | grep :$port &> /dev/null
PortUsed=$?
if [ "$PortUsed" = "0" ]; then
	echo "it seems that there is already a process on port $port"
	echo "Please close this process or install on another port"
	echo ""
	echo "==========================="
	echo ""
	echo "Exiting script"
	echo ""
	exit 1
fi

echo ""
echo "==========================="
echo ""
echo -e "\033[38;5;148mPlease enter a tracker redirecting url\033[39m"
echo "Example:  google.com"
read -p "(Default; NONE):" RedirectURL
if [ "$RedirectURL" = "" ]; then
        RedirectURL=NONE
fi

echo ""
echo "==========================="
echo ""
echo -e "\033[38;5;148mPlease enter the installation configuration number of your choice:\033[39m"
echo ""
echo -e "[1] - Tracker listens to both UDP and TCP. \n[2] - Tracker listens to TCP only. \n[3] - Tracker listens to UDP only."
echo ""
read -p "(Default is 1:)" TrackerProtocals
if [ "$TrackerProtocals" = "" ]; then
        TrackerProtocals=1
fi
echo ""
echo "==========================="
echo ""
echo -e "\033[38;5;148mThe following configuration will be installed for OpenTracker:\033[39m"
echo ""

if [ "$TrackerProtocals" = "1" ]; then
        Display="Both UDP and TCP"
fi
if [ "$TrackerProtocals" = "2" ]; then
        Display="TCP ONLY"
fi
if [ "$TrackerProtocals" = "3" ]; then
        Display="UPD ONLY"
fi

echo -e "Tracker Port - \033[38;5;148m$port\033[39m \nTracker redirect URL - \033[38;5;148m$RedirectURL\033[39m \nTracker Protocals - \033[38;5;148m$Display\033[39m"
echo ""
read -p "Press [Enter] key to confirm and start install..."

echo "Installing, Please wait..."
echo ""
#Installing OpenTracker

LinuxVersion="apt-get"
LinuxInstall="apt-get install -y libz-dev"

if [[ `apt-get 2>&1` =~ command\ not ]]
then
    LinuxVersion="yum"
    LinuxInstall="yum install -y zlib-devel build-essential"
    echo "/etc/init.d/opentracker" >> /etc/rc.local
fi


$LinuxVersion update -y
$LinuxInstall cvs make gcc

mkdir /etc/opentracker
cd /etc/opentracker
wget http://dl.fefe.de/libowfat-0.28.tar.bz2
tar -jxvf libowfat-0.28.tar.bz2
rm -f libowfat-0.28.tar.bz2
mv libowfat-0.28 libowfat
cd libowfat
make
make install
cd ..
cvs -d:pserver:anoncvs@cvs.erdgeist.org:/home/cvsroot co opentracker
cd opentracker
make
make install

cd /etc/opentracker/opentracker

if [ "$TrackerProtocals" = "1" ]; then
        TrackerProtocal="listen.tcp_udp 0.0.0.0:"
fi
if [ "$TrackerProtocals" = "2" ]; then
        TrackerProtocal="listen.tcp 0.0.0.0:"
fi
if [ "$TrackerProtocals" = "3" ]; then
        TrackerProtocal="listen.udp 0.0.0.0:"
fi

echo "$TrackerProtocal$port" > opentracker.conf

if [ "$RedirectURL" != "NONE" ]; then
        echo "tracker.redirect_url http://$RedirectURL" >> opentracker.conf
fi

./opentracker -f opentracker.conf &
disown

cd /etc/init.d/
echo "#!/bin/bash" > opentracker 
echo "cd /etc/opentracker/opentracker" >> opentracker
echo "./opentracker -f opentracker.conf &" >> opentracker
echo "disown" >> opentracker
chmod 755 opentracker

if [ "$LinuxVersion" = "apt-get" ]; then
	update-rc.d opentracker defaults
fi

clear
echo "==========================="
echo "DONE!"
echo ""
echo "You can now add the following address to your announce list:"
echo ""

IpAddress=$(wget http://checkip.dyndns.org/ -qO - | grep -Eo '\<[[:digit:]]{1,3}(\.[[:digit:]]{1,3}){3}\>')
if [ "$TrackerProtocals" = "1" ]; then
        echo -e "\033[38;5;148mhttp://$IpAddress:$port/announce \nudp://$IpAddress:$port/announce\033[39m"
fi
if [ "$TrackerProtocals" = "2" ]; then
	echo -e "\033[38;5;148mhttp://$IpAddress:$port/announce\033[39m"
fi
if [ "$TrackerProtocals" = "3" ]; then
	echo -e "\033[38;5;148mudp://$IpAddress:$port/announce\033[39m"
fi

echo ""
echo "You can also use a domain name (rather than an IP address)"
echo "NOTE: If Server is rebooted OpenTracker will automatically start everytime on port $port"
echo -e "To view basic Tracker stats: \033[38;5;148mhttp://$IpAddress:$port/stats\033[39m"
echo ""
echo "Enjoy!"
echo "==========================="
echo ""
