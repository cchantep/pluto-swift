#! /bin/sh

if [ $# -lt 2 ]; then
	echo "Illegal argument number" 
	echo "Usage: datecalc.sh [+|-] [days]"
	exit
fi

if [ "$1" != "+" -a "$1" != "-" ]; then
	echo "Invalid operator, expected '+' or '-': $1"
	echo "Usage: datecalc.sh [+|-] [days]"
	exit
fi

MONTHDAYSCMD=`dirname $0`"/monthdays.sh"

OPERATOR="$1"
OPERAND="$2"
MONTHTXT="no"

if [ ! -z "$3" ]; then
	MONTHTXT="yes"
fi

DAY=`date +'%d'`
MONTH=`date +'%m' | sed -e 's/^0//'`
YEAR=`date +'%Y'`

DAY=`expr $DAY $OPERATOR $OPERAND`

# Roll date according operator and operand
if [ $DAY -lt 1 -o $DAY -gt `"$MONTHDAYSCMD" "$MONTH" "$YEAR"` ]; then
	M=`echo "$DAY" | sed -e 's/^-//'`
	MD=""

	if [ "$OPERATOR" = "+" ]; then
		MD=`$MONTHDAYSCMD $MONTH $YEAR`
	fi

	MONTH=`expr $MONTH $OPERATOR 1`

	if [ $MONTH -eq 0 ]; then
		YEAR=`expr $YEAR $OPERATOR 1`
		MONTH=12
	fi
	
	if [ "$OPERATOR" = "-" ]; then
		MD=`$MONTHDAYSCMD $MONTH $YEAR`
	fi

	# while days back are greater 
	# than month day count
	while [ $M -ge $MD ]; do
	    M=`expr $M - $MD`
	    MONTH=`expr $MONTH $OPERATOR 1`

	    if [ $MONTH -eq 0 ]; then
		MONTH="12"
		YEAR=`expr $YEAR - 1`
	    fi

	    MD=`$MONTHDAYSCMD $MONTH $YEAR`
	done

	if [ "$OPERATOR" = "+" ]; then
		DAY="$M"
		MONTH=`expr $MONTH - 1`
	else
		DAY=`expr $MD $OPERATOR $M`
	fi
fi

# Prepare in apache log date format
## prepare month
if [ "$MONTHTXT" = "yes" ]; then
	if [ $MONTH = "1" ]; then
		MONTH="Jan"
	fi

	if [ $MONTH = "2" ]; then
		MONTH="Feb"
	fi

	if [ $MONTH = "3" ]; then
		MONTH="Mar"
	fi

	if [ $MONTH = "4" ]; then
		MONTH="Apr"
	fi

	if [ $MONTH = "5" ]; then
		MONTH="May"
	fi

	if [ $MONTH = "6" ]; then
		MONTH="Jun"
	fi

	if [ $MONTH = "7" ]; then
		MONTH="Jul"
	fi

	if [ $MONTH = "8" ]; then
		MONTH="Aug"
	fi

	if [ $MONTH = "9" ]; then
		MONTH="Sep"
	fi

	if [ $MONTH = "10" ]; then
		MONTH="Oct"
	fi

	if [ $MONTH = "11" ]; then
		MONTH="Nov"
	fi

	if [ $MONTH = "12" ]; then
		MONTH="Dec"
	fi
else
	if [ $MONTH -lt 10 ]; then
		MONTH="0$MONTH"
	fi
fi

## prepare day
if [ $DAY -lt 10 ]; then
	DAY="0$DAY"
fi

echo "$YEAR-$MONTH-$DAY"
