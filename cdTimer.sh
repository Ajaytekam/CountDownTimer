#!/bin/bash 

CheckApps() {

CHespeak=`which espeak`
CHtoilet=`which toilet`

if [[ "$CHespeak" == ""  && "CHtoilet" == "" ]]
then
    echo "espeak and toilet is not installed"
    echo "please install it first"
    echo "Command for installation"
    echo 
    echo "sudo apt install espeak toilet -y"
    exit
elif [ "$CHespeak" == "" ]
then
    echo "espaek is not installed"
    echo "please install it first"
    echo "Command for installation"
    echo 
    echo "sudo apt install espeak -y"
    exit
elif [ "CHtoilet" == "" ]
then
    echo "toilet is not installed"
    echo "please install it first"
    echo "Command for installation"
    echo 
    echo "sudo apt install toilet -y"
    exit
fi

}

Help_Message() {
    toilet -w 200 -f standard "CountDown Timer"
    echo 
    echo "Usage: "
    echo 
    echo "$0 [-t/-T] <time_in_minutes> [-m/-M] <custom_message>"
    echo 
    echo "Options: "
    echo 
    echo -e "-t/-T:\tSet the timer to given time in minutes"
    echo -e "-m/-M:\tSet the custom message"
    exit
}

ShowTime() {
    Mhours=$1
    Mminutes=$2
    sec=60
    
    while [ $sec -gt 0 ] 
    do
        clear

        if [ $Mhours -lt 10 ]
        then
            hours="0$Mhours"
        else 
            hours=$Mhours
        fi

        if [ $Mminutes -lt 10 ]
        then
            minutes="0$Mminutes"
        else
            minutes=$Mminutes
        fi

        if [ $sec -lt 10 ]
        then
            Tsec="0$sec"
        else
            Tsec=$sec
        fi

        toilet -w 200 -f term -F border "$hours:$minutes:$Tsec"
        sleep 1
        sec=$((sec-1))
    done
}

# Main Function 
# default timer is 60 minutes
CheckApps

t_count=60
message="Time is Over"

##
## parsing Arguments 
##
if [[ "$1" == "-t" || "$1" == "-T" ]]
then 
    t_count=$2
elif [[ "$1" == "-m" || "$1" == "-M" ]]
then 
    message=$2    
elif [[ "$1" == "-h" || "$1" == "--H" ]]
then 
    Help_Message
fi


if [[ "$3" == "-t" || "$3" == "-T" ]]
then 
    t_count=$4
elif [[ "$3" == "-m" || "$3" == "-M" ]]
then 
    message=$4
fi 

while true
do
    clear
    t_count=$((t_count-1))
    if [ $t_count -lt 0 ]
    then
        break
    fi
    hours=`echo -e $t_count'/60\n' | bc -q`
    minutes=`echo -e $t_count'%60\n' | bc -q`
    ShowTime $hours $minutes
done

clear
echo  -e "\033[32;5m"
toilet -w 200 -f small "0 0 : 0 0 : 0 0"
toilet -w 200 -f small "$message"
echo -e "\033[0m"
while true
do
    espeak "$message"
done
