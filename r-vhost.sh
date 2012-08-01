#! /bin/sh

# Inputs
while [ ! -f "$VHOSTFILE" ]; do
	echo "Path to vhost file (ex: /etc/httpd/conf/vhosts/site.vhost):"
	read VHOSTFILE
done

###

echo "---"
echo "Backup removal summary"
echo "  Vhost file: $VHOSTFILE"

###

rm -f "$VHOSTFILE"