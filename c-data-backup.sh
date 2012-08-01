#! /bin/sh

if [ $# -ne 1 -a "$DESTFILE" = "" ]; then
	echo "Illegal argument number" 
	exit
fi

OUTFILE="$1"
FILEND=""

if [ "$OUTFILE" = "" ]; then
	OUTFILE="$DESTFILE"
fi

if [ "$TEMPLATE" = "" ]; then
	echo "Data backup script template (ex: /tmp/backup.tmpl): "
	read TEMPLATE
fi

if [ -f "$PWD/$OUTFILE" ]; then
        OUTFILE="$PWD/$OUTFILE"
fi

while [ "$SITEHOME" = "" ]; do
	echo "Site home (ex: /var/www/www.test.com):"
	read SITEHOME
done
	
while [ "$DATADIR" = "" ]; do
	echo "Data directory (relative to project home, ex: htdocs) :"
	read DATADIR
done

while [ "$BACKUPDIR" = "" ]; do
	echo "Backup directory (ex: /backup/www.test.com/data/):"
	read BACKUPDIR
done

while [ "$DOMAIN" = "" ]; do
	echo "Site main domain (ex: www.test.com):"
	read DOMAIN
done

if [ "$FILEND" = "" ]; then
	echo "Backup suffix (empty for default \"-data_\"):"
	read FILEND
fi

if [ "$FILEND" = "" ]; then
	FILEND="-data_";
fi

while [ "$SCRIPT_LIST" = "" ]; do
        echo "Path to script list where to append backup one (ex: /tmp/scripts.lst): "
        read SCRIPT_LIST
done

###

echo "---"
echo "Data backup summary"
echo "  Site home: $SITEHOME"
echo "  Site main domain: $DOMAIN"
echo "  Data directory path: $SITEHOME/$DATADIR"
echo "  Data backup directory: $BACKUPDIR"
echo "  Backup suffix: $FILEND"
echo "  Generated backup script: $OUTFILE"
echo "  Script list path: $SCRIPT_LIST"

REPL="s|#PROJECT_HOME#|$SITEHOME|g"
REPL="$REPL;s|#DATADIR#|$DATADIR|g"
REPL="$REPL;s|#BACKUPDIR#|$BACKUPDIR|g"
REPL="$REPL;s|#PROJECTNAME#|$DOMAIN|g"
REPL="$REPL;s|#FILEND#|$FILEND|g"

sed -e "$REPL" < "$TEMPLATE" > "$OUTFILE"
chmod u+x "$OUTFILE"
echo "$OUTFILE" >> "$SCRIPT_LIST"
