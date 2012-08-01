#! /bin/sh

while [ "$DESTFILE" = "" ]; do
        echo "Path where to write extractor script: "
        read DESTFILE

        DESTDIR=`dirname "$DESTFILE"`

        if [ ! -d "$DESTDIR" ]; then
                echo "Directory does not exist: $DESTDIR"
                DESTFILE=""
        else
                if [ ! -w "$DESTFILE" ]; then
                        echo "File is not writeable: $DESTFILE"
                        DESTFILE=""
                fi
        fi
done

###
echo "---"
echo "User xferlog summary "
echo "  Extractor script: $DESTFILE"

rm -f "$DESTFILE"