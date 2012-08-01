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
	echo "PostgreSQL backup script template: "
	read TEMPLATE
fi

while [ "$BACKUPDIR" = "" ]; do
	echo "Backup directory (where to put pgsql backup): "
	read BACKUPDIR
done

while [ "$SCRIPT_LIST" = "" ]; do
	echo "Path to script list where to append backup one (ex: /tmp/scripts.lst): "
	read SCRIPT_LIST
done

while [ "$USERNAME" = "" ]; do
	echo "PostgreSQL user to backup: "
	read USERNAME
done

while [ "$PGSQLPASS" = "" ]; do
	echo "Password for PostgreSQL user \"$USERNAME\" (empty for global one): "
	read PGSQLPASS

	if [ "$PGSQLPASS" = "" ]; then
		PGSQLPASS="$USERPASS"
	fi
done

while [ "$DBNAME" = "" ]; do
	echo "Name of pgsql database: "
	read DBNAME
done

echo "---"
echo "Summary:"
echo "  Backup directory: $BACKUPDIR"
echo "  Script list where to append pgsql one: $SCRIPT_LIST"
echo "  PostgreSQL user name: $USERNAME"
echo "  PostgreSQL user password: $PGSQLPASS"
echo "  Database name: $DBNAME"
echo "  Generated script: $SCRIPT"

CONF="s|#BACKUPDIR#|$BACKUPDIR|g"
CONF="$CONF;s|#USER#|$USERNAME|g"
CONF="$CONF;s|#PASSWD#|$PGSQLPASS|g"
CONF="$CONF;s|#DBNAME#|$DBNAME|g"

sed -e "$CONF" < "$TEMPLATE" > "$SCRIPT"
chmod u+x "$SCRIPT"
echo "$SCRIPT" >> "$SCRIPT_LIST"
