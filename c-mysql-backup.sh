#! /bin/sh

if [ ! $# -eq 1 -a "$DESTFILE" = "" ]; then
	echo "Illegal argument number"
	exit
fi 

SCRIPT="$1"

if [ "$DESTFILE" != "" ]; then
	SCRIPT="$DESTFILE"
fi

if [ -f "$PWD/$SCRIPT" ]; then
	SCRIPT="$PWD/$SCRIPT"
fi

if [ "$TEMPLATE" = "" ]; then
	echo "MySQL backup script template: "
	read TEMPLATE
fi

while [ "$BACKUPDIR" = "" ]; do
	echo "Backup directory (where to put mysql backup): "
	read BACKUPDIR
done

while [ "$SCRIPT_LIST" = "" ]; do
	echo "Path to script list where to append backup one (ex: /tmp/scripts.lst): "
	read SCRIPT_LIST
done

while [ "$USERNAME" = "" ]; do
	echo "MySQL user to backup: "
	read USERNAME
done

while [ "$MYSQLPASS" = "" ]; do
	echo "Password for MySQL user \"$USERNAME\" (empty for global one): "
	read MYSQLPASS

	if [ "$MYSQLPASS" = "" ]; then
		MYSQLPASS="$USERPASS"
	fi
done

while [ "$DBNAME" = "" ]; do
	echo "Name of mysql database: "
	read DBNAME
done

echo "---"
echo "Summary:"
echo "  Backup directory: $BACKUPDIR"
echo "  Script list where to append mysql one: $SCRIPT_LIST"
echo "  MySQL user name: $USERNAME"
echo "  MySQL user password: $MYSQLPASS"
echo "  Database name: $DBNAME"
echo "  Generated script: $SCRIPT"

CONF="s|#BACKUPDIR#|$BACKUPDIR|g"
CONF="$CONF;s|#USER#|$USERNAME|g"
CONF="$CONF;s|#PASSWD#|$MYSQLPASS|g"
CONF="$CONF;s|#DBNAME#|$DBNAME|g"

sed -e "$CONF" < "$TEMPLATE" > "$SCRIPT"
chmod u+x "$SCRIPT"
echo "$SCRIPT" >> "$SCRIPT_LIST"
