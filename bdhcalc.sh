#!/bin/bash
# - title        : Calculator for Bandwidth
# - description  : This script will assist in calculating the Max Possible Bandwidth by hours active
# - author       : Kevin Carter
# - date         : 2011-12-23
# - version      : 3.0    
# - usage        : bash bdcalc.sh
# - notes        : This is a bandwidth calculating script.
# - bash_version : >= 3.2.48(1)-release
#### ========================================================= ####

# System Check for Compatibility
if [ `which bc` ];then
	
bc=`which bc`

# Seconds, Minutes, Hours
SM=`echo "60 * 60" | $bc -l`

# How Many Bits in a Byte
BITS="8"

# How Many KiloBytes make a MegaByte
MIGS="1024"

# Margin of Error, percentage in decimal format
REPM=".07"

# Default Variable Information 
MPS="$1"
HRS="$2"

if [ -z $MPS ]; then
clear
echo "
How Many Megabits per-Second are we computing?
Simply enter a Number, for Example :
if you are attempting to compute a 10MPS interface enter 10"
read -p "Enter the Value here :" -e MPS
fi

if [ `echo "$MPS" | grep '[a-zA-Z]'` ];then
echo "You know Damn Well that `echo -e "\033[1;31m$MPS\033[0m"` would not work here, try again..."
exit 1
	elif [ `echo "$MPS" | grep '[^a-zA-Z0-9\.]'` ];then
	echo "No nonsense characters please, and `echo -e "\033[1;31m$MPS\033[0m"` is nonsense. Try again..."
	exit 1
		elif [ $MPS == 0 ];then
			echo "Congratulations Genius, `echo -e "\033[1;31m$MPS\033[0m"` multiplied by anything will always be `echo -e "\033[1;31m$MPS\033[0m"`, Try again..."
			exit 1
fi
if [ -z $HRS ]; then
clear
echo "
How Many Hours Have you been Billed?
Simply enter a Number, for Example :
if you were billed 10 HOURS enter 10"
read -p "Enter the Value here :" -e HRS
fi

if [ `echo "$HRS" | grep '[a-zA-Z]'` ];then
echo "You know Damn Well that `echo -e "\033[1;31m$HRS\033[0m"` would not work here, try again..."
exit 1
	elif [ `echo "$HRS" | grep '[^a-zA-Z0-9\.]'` ];then
	echo "No nonsense characters please, and `echo -e "\033[1;31m$HRS\033[0m"` is nonsense. Try again..."
	exit 1
		elif [ $HRS == 0 ];then
			echo "Congratulations Genius, `echo -e "\033[1;31m$HRS\033[0m"` multiplied by anything will always be `echo -e "\033[1;31m$HRS\033[0m"`, Try again..."
			exit 1
fi
CHRS=`echo "scale=2;$HRS * 1" | $bc -l`

CREPM=`echo "$REPM * 100" | $bc -l`

# Computing the Optimal Values 
SMH=`echo "scale=4;$SM * $CHRS" | $bc -l`
OKBPM=`echo "scale=4;$SMH * $MPS" | $bc -l`
OMBPM=`echo "scale=4;$OKBPM / $BITS" | $bc -l`
OGBPM=`echo "scale=4;$OMBPM / $MIGS" | $bc -l`
OTBPM=`echo "scale=4;$OGBPM / $MIGS" | $bc -l`


# Computing Values with the Margin of Error
PRMBPM=`echo "scale=4;$OMBPM * $REPM" | $bc -l`
      RMBPM=`echo "scale=4;$OMBPM - $PRMBPM" | $bc -l`
PRGBPM=`echo "scale=4;$OGBPM * $REPM" | $bc -l`
      RGBPM=`echo "scale=4;$OGBPM - $PRGBPM" | $bc -l`
PRTBPM=`echo "scale=4;$OTBPM * $REPM" | $bc -l`
      RTBPM=`echo "scale=4;$OTBPM - $PRTBPM" | $bc -l`
	  

clear
echo "You have specified a `echo -e "\033[1;35m$MPS\033[0m"` MegaBit Per Second Interface"
echo "You have specified `echo -e "\033[1;35m$HRS\033[0m"` Billing Hour(s)"
echo "------------------------------------------------------------------------------"
echo "Definitions                                                                 ::"
echo "OPH = `echo -e "\033[1;32mOptimal Per Hour\033[0m"`"
echo "EPH = `echo -e "\033[1;32mEstimated Per Hour\033[0m"` - CONTAINS MARGIN OF ERROR -"
echo "------------------------------------------------------------------------------"
echo "The Computations were done using these constants                            ::"
echo "Seconds Billed          : `echo -e "\033[32m$SMH\033[0m"`"
echo "Margin of error as a %  : `echo -e "\033[32m$CREPM\033[0m"`"
echo "------------------------------------------------------------------------------"
echo "The total Bandwidth Possible in `echo -e "\033[1;35m$HRS\033[0m"` Hour(s) for a `echo -e "\033[1;35m$MPS\033[0m"` MBPS Interface ::"
echo "Bandwidth in MegaBytes | OPH : `echo -e "\033[36m$OMBPM\033[0m"` MB   [EPH :`echo -e "\033[1;36m$RMBPM\033[0m"` MB]"
echo "Bandwidth in GigaBytes | OPH : `echo -e "\033[36m$OGBPM\033[0m"` GB   [EPH :`echo -e "\033[1;36m$RGBPM\033[0m"` GB]"
echo "Bandwidth in TeraBytes | OPH : `echo -e "\033[36m$OTBPM\033[0m"` TB   [EPH :`echo -e "\033[1;36m$RTBPM\033[0m"` TB]"
echo "| ---------------- Developed By Kevin Carter @ RackerUa.com ---------------- |"
exit 0
fi

RHEL=$(cat /etc/issue | grep -i '\(centos\)\|\(red\)')
DEBIAN=$(cat /etc/issue | grep -i '\(debian\)\|\(ubuntu\)')
echo "`echo -e "\033[1;31mbc\033[0m"` is not installed on your System,"
	if [ "$RHEL" ];then
		echo "I can see that you are using a RHEL Based system," 
		echo "you will have to install `echo -e "\033[1;31mbc\033[0m"` with yum install `echo -e "\033[1;31mbc\033[0m"`"
		exit 1
			elif [ "$DEBIAN" ];then 
			echo "I can see that you are on a Debian Based system," 
			echo "To install `echo -e "\033[1;31mbc\033[0m"` you will have to, apt-get install `echo -e "\033[1;31mbc\033[0m"`" 
			exit 1
				else 
					clear
					echo "I could not reliably determin your system type,"
					echo "You will have to install `echo -e "\033[1;31mbc\033[0m"` if you want to use this calculator."
					exit 0
fi

