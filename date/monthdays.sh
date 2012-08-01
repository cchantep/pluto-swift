#! /bin/sh

###
# brief: Calculate days in specified month
# author: Cedric Chantepie
###

if [ $# -ne 2 ]; then
    echo "Illegal argument number"
    echo "Usage: monthdays.sh [month as int] [4 digits year]"
    exit
fi

MONTH="$1"
YEAR="$2"

A='|1| |3| |5| |7| |8| |10| |12|'
B='|4| |6| |9| |11|'

if [ $MONTH -eq 2 ]; then
    Q=`expr $YEAR / 4`
    C=`expr $YEAR / 100`
    
    if [ `expr $Q '*' 4` -eq $YEAR -a ! `expr $C '*' 100` -eq $YEAR ]; then
	DAY=29
    else
	DAY=28
    fi
fi

if [ `echo "$A" | grep "|$MONTH|" | wc -l` -eq 1 ]; then
    DAY=31
fi

if [ `echo "$B" | grep "|$MONTH|" | wc -l` -eq 1 ]; then
    DAY=30
fi

echo $DAY