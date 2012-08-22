#!/bin/bash
# - title        : Calculator for Bandwidth
# - description  : This script will assist in calculating the Max Possible Bandwidth in a month
# - License      : GPLv3
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

# The Mean amount of days based on the Solar Day
MEANDAYS="365.24219"

# Seconds, Minutes, Hours
SMH=`echo "scale=4;60 * 60 * 24" | $bc -l`

# Days in a Month
DIAM=`echo "scale=4;$MEANDAYS / 12" | $bc -l `

# How Many Bits in a Byte
BITS="8"

# How Many KiloBytes make a MegaByte
MIGS="1024"

# Margin of Error, percentage in decimal format
REPM=".07"

# Default Variable Information 
MPS="$1"

if [ -z $MPS ]; then
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

CREPM=`echo "$REPM * 100" | $bc -l`

# Computing the Optimal Values 
SMHDIAM=`echo "$SMH * $DIAM" | $bc -l`
OKBPM=`echo "scale=4;$SMHDIAM * $MPS" | $bc -l`
OMBPM=`echo "scale=4;$OKBPM / $BITS" | $bc -l`
OGBPM=`echo "scale=4;$OMBPM / $MIGS" | $bc -l`
OTBPM=`echo "scale=4;$OGBPM / $MIGS" | $bc -l`

OMBPD=`echo "scale=4;$OMBPM / $DIAM" | $bc -l`
OGBPD=`echo "scale=4;$OGBPM / $DIAM" | $bc -l`
OTBPD=`echo "scale=4;$OTBPM / $DIAM" | $bc -l`


# Computing Values with the Margin of Error
PRMBPM=`echo "scale=4;$OMBPM * $REPM" | $bc -l`
      RMBPM=`echo "scale=4;$OMBPM - $PRMBPM" | $bc -l`
PRGBPM=`echo "scale=4;$OGBPM * $REPM" | $bc -l`
      RGBPM=`echo "scale=4;$OGBPM - $PRGBPM" | $bc -l`
PRTBPM=`echo "scale=4;$OTBPM * $REPM" | $bc -l`
      RTBPM=`echo "scale=4;$OTBPM - $PRTBPM" | $bc -l`

PRMBPD=`echo "scale=4;$OMBPD * $REPM" | $bc -l`
      RMBPD=`echo "scale=4;$OMBPD - $PRMBPD" | $bc -l`
PRGBPD=`echo "scale=4;$OGBPD * $REPM" | $bc -l`
      RGBPD=`echo "scale=4;$OGBPD - $PRGBPD" | $bc -l`
PRTBPD=`echo "scale=4;$OTBPD * $REPM" | $bc -l`
      RTBPD=`echo "scale=4;$OTBPD - $PRTBPD" | $bc -l`

clear
echo "You have specified a `echo -e "\033[1;35m$MPS\033[0m"` MegaBit Per Second Interface"
echo "------------------------------------------------------------------------------"
echo "Definitions                                                                 ::"
echo "OPM = `echo -e "\033[1;32mOptimal Per-Month\033[0m"`"
echo "OPD = `echo -e "\033[1;32mOptimal Per-Day\033[0m"`"
echo "REPM = `echo -e "\033[1;32mReal Estimated Per-Month\033[0m"`"
echo "REPD = `echo -e "\033[1;32mReal Estimated Per-Day\033[0m"`"
echo "------------------------------------------------------------------------------"
echo "The Computations were done using these constants                            ::"
echo "Mean Days in a Year     : `echo -e "\033[32m$MEANDAYS\033[0m"`"
echo "Mean Days in a Month    : `echo -e "\033[32m$DIAM\033[0m"`"
echo "Seconds in a day        : `echo -e "\033[32m$SMH\033[0m"`"
echo "Margin of error as a %  : `echo -e "\033[32m$CREPM\033[0m"`"
echo "------------------------------------------------------------------------------"
echo "The total Bandwidth Possible in a `echo -e "\033[36mMonth\033[0m"` for a `echo -e "\033[1;35m$MPS\033[0m"` MBPS Interface ::"
echo "Bandwidth in MegaBytes | OPM : `echo -e "\033[36m$OMBPM\033[0m"` MB   [REPM : `echo -e "\033[36m$RMBPM\033[0m"` MB]" 
echo "Bandwidth in Gigabytes | OPM : `echo -e "\033[36m$OGBPM\033[0m"` GB   [REPM : `echo -e "\033[36m$RGBPM\033[0m"` GB]"
echo "Bandwidth in TeraBytes | OPM : `echo -e "\033[36m$OTBPM\033[0m"` TB   [REPM : `echo -e "\033[36m$RTBPM\033[0m"` TB]"
echo "------------------------------------------------------------------------------"
echo "The total Bandwidth Possible in a  `echo -e "\033[1;36mDay\033[0m"`  for a `echo -e "\033[1;35m$MPS\033[0m"` MBPS Interface ::"
echo "Bandwidth in MegaBytes | OPD : `echo -e "\033[1;36m$OMBPD\033[0m"` MB   [REPD :`echo -e "\033[1;36m$RMBPD\033[0m"` MB]"
echo "Bandwidth in GigaBytes | OPD : `echo -e "\033[1;36m$OGBPD\033[0m"` GB   [REPD :`echo -e "\033[1;36m$RGBPD\033[0m"` GB]"
echo "Bandwidth in TeraBytes | OPD : `echo -e "\033[1;36m$OTBPD\033[0m"` TB   [REPD :`echo -e "\033[1;36m$RTBPD\033[0m"` TB]"
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

