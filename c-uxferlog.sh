#! /bin/sh

#####
# brief: Extract information from (FTP) xferlog related to specified user
# author: Cedric Chantepie ()
# date: 2009-05-13
#####

while [ "$USERNAME" = "" ]; do
	echo "FTP user name: "
	read USERNAME
done

while [ "$MASTERLOG" = "" -o ! -r "$MASTERLOG" ]; do
	if [ "$MASTERLOG" != "" ]; then
		echo "File does not exist: $MASTERLOG"
	fi

	if [ -r "/var/log/xferlog" ]; then
		MASTERLOG="/var/log/xferlog"
		echo "Path to master xferlog (default: $MASTERLOG): "
		read TMP

		if [ "$TMP" != "" ]; then
			MASTERLOG="$TMP"
		fi
	else
		echo "Path to master xferlog (e.g. /var/log/xferlog): "
		read MASTERLOG
	fi
done

while [ "$USERLOG" = "" ]; do
	echo "Path where to write data extracted from master log: "
	read USERLOG

	DESTDIR=`dirname "$USERLOG"`

	if [ ! -d "$DESTDIR" ]; then
		echo "Directory does not exist: $DESTDIR"
		USERLOG=""
	else 
		touch "$USERLOG"

		if [ ! -w "$USERLOG" ]; then
			echo "File is not writeable: $USERLOG"
			USERLOG=""
		fi
	fi
done

while [ "$DESTFILE" = "" ]; do
        echo "Path where to write extractor script: "
        read DESTFILE

        DESTDIR=`dirname "$DESTFILE"`

        if [ ! -d "$DESTDIR" ]; then
                echo "Directory does not exist: $DESTDIR"
                DESTFILE=""
        else
                touch "$DESTFILE"

                if [ ! -w "$DESTFILE" ]; then
                        echo "File is not writeable: $DESTFILE"
                        DESTFILE=""
                fi
        fi
done

###
echo "---"
echo "User xferlog summary "
echo "  FTP user name: $USERNAME"
echo "  Master log: $MASTERLOG"
echo "  User log: $USERLOG"
echo "  Extractor script: $DESTFILE"

cat > "$DESTFILE" << EOF
#! /bin/sh

grep " $USERNAME ftp " < "$MASTERLOG" > "$USERLOG"
EOF

chmod u+x "$DESTFILE"
