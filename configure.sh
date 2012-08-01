#! /bin/sh

#####
# brief: Setup hosting wizard script
# author: Cedric Chantepie
# date: 2010-02-09
#####

echo "Welcome to NOZICAA Hosting Wizard setup ..."
echo "... please provide me some platform dependent settings."

# Sed
DEFAULT=`which sed`
QUESTION="Path to sed command"
VALUE="x"

while [ ! -x "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
SED_CMD="$VALUE"

# Find
DEFAULT=`which find`
QUESTION="Path to find command"
VALUE="x"

while [ ! -x "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
FIND_CMD="$VALUE"

# Hosting wizard dir
DEFAULT="/usr/share/hosting"
QUESTION="Path to hosting wizard directory"
VALUE="x"

while [ ! -d "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
HOSTINGWIZ_DIR="$VALUE"

# Useradd
DEFAULT=`which useradd`
QUESTION="Path to useradd command"
VALUE="x"

while [ ! -x "$VALUE" ]; do
	echo "$QUESTION (default: $DEFAULT): "
	read VALUE

	if [ "$VALUE" = "" ]; then
		VALUE="$DEFAULT"
	fi
done
USERADD_CMD="$VALUE"

# Userdel
DEFAULT=`which userdel`
QUESTION="Path to userdel command"
VALUE="x"

while [ ! -x "$VALUE" ]; do
	echo "$QUESTION (default: $DEFAULT): "
	read VALUE

	if [ "$VALUE" = "" ]; then
		VALUE="$DEFAULT"
	fi
done
USERDEL_CMD="$VALUE"

# Passwd
DEFAULT=`which passwd`
QUESTION="Path to passwd command"
VALUE="x"

while [ ! -x "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
PASSWD_CMD="$VALUE"

# Passwd file
DEFAULT="/etc/passwd"
QUESTION="Path to passwd file"
VALUE="x"

while [ ! -r "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
PASSWD_FILE="$VALUE"

### Substitute at 'c-user.sh' ###
"$SED_CMD" -e "s|@USERADD_CMD@|$USERADD_CMD|g;s|@PASSWD_CMD@|$PASSWD_CMD|g;s|@PASSWD_FILE@|$PASSWD_FILE|g" < "$HOSTINGWIZ_DIR/c-user.sh.in" > "$HOSTINGWIZ_DIR/c-user.sh" && chmod u+x "$HOSTINGWIZ_DIR/c-user.sh"

# Awstats config dir
DEFAULT="/etc/awstats"
QUESTION="Path to Awstats config directory"
VALUE="x"

while [ ! -d "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
AWSTATS_CFGDIR="$VALUE"

# Awstats web dir
DEFAULT="/usr/share/awstats/wwwroot"
QUESTION="Path to Awstats web directory"
VALUE="x"

while [ ! -d "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
AWSTATS_WEBDIR="$VALUE"

# Awstats CGI dir
DEFAULT="/usr/share/awstats/wwwroot/cgi-bin"
QUESTION="Path to Awstats CGI directory (containing awstats.pl)"
VALUE="x"

while [ ! -d "$VALUE" -o ! -x "$VALUE/awstats.pl" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
AWSTATS_CGIDIR="$VALUE"

# Awstats passwd file
DEFAULT="$AWSTATS_CFGDIR/htpasswd"
QUESTION="Path to Awstats password file"
VALUE="/x/x"

while [ ! -d `dirname "$VALUE"` ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
AWSTATS_PASSWD_FILE="$VALUE"

# Htpasswd
DEFAULT=`which htpasswd`
QUESTION="Path to htpasswd command"
VALUE="x"

while [ ! -x "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
HTPASSWD_CMD="$VALUE"

### Substitute at 'c-awstats-http.sh' ###
"$SED_CMD" -e "s|@AWSTATS_CFGDIR@|$AWSTATS_CFGDIR|g;s|@HTPASSWD_CMD@|$HTPASSWD_CMD|g;s|@AWSTATS_PASSWD_FILE@|$AWSTATS_PASSWD_FILE|g" < "$HOSTINGWIZ_DIR/c-awstats-http.sh.in" > "$HOSTINGWIZ_DIR/c-awstats-http.sh" && chmod u+x "$HOSTINGWIZ_DIR/c-awstats-http.sh" 

### Substitute at 'c-awstats-ftp.sh' ###
"$SED_CMD" -e "s|@AWSTATS_CFGDIR@|$AWSTATS_CFGDIR|g" < "$HOSTINGWIZ_DIR/c-awstats-ftp.sh.in" > "$HOSTINGWIZ_DIR/c-awstats-ftp.sh" && chmod u+x "$HOSTINGWIZ_DIR/c-awstats-ftp.sh"

# Date command
DEFAULT=`which date`
QUESTION="Path to date command"
VALUE="x"

while [ ! -x "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
DATE_CMD="$VALUE"

# Tar command
DEFAULT=`which tar`
QUESTION="Path to tar command"
VALUE="x"

while [ ! -x "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
TAR_CMD="$VALUE"

### Substitute at 'backup-data.tmpl' ###
"$SED_CMD" -e "s|@HOSTINGWIZ_DIR@|$HOSTINGWIZ_DIR|g;s|@DATE_CMD@|$DATE_CMD|g;s|@TAR_CMD@|$TAR_CMD|g" < "$HOSTINGWIZ_DIR/backup-data.tmpl.in" > "$HOSTINGWIZ_DIR/backup-data.tmpl"

# Web server root
DEFAULT="/var/www"
QUESTION="Path to web root"
VALUE="x"

while [ ! -d "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
WEB_ROOT="$VALUE"

# Backup root
DEFAULT="/backup"
QUESTION="Path to backup root directory"
VALUE="x"

while [ ! -d "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
BACKUP_ROOT="$VALUE"

# Xfer log extractors directory
DEFAULT="/usr/share/awstats/xfer.d"
QUESTION="Path to xferlog extractors directory"
VALUE="x"

while [ ! -d "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
XFER_EXTRACTOR_DIR="$VALUE"

# Default locale
DEFAULT="fr_FR"
QUESTION="Default locale"
VALUE=""

while [ -z "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
DEFAULT_LOCALE="$VALUE"

### Substitute at 'create.sh' ###
"$SED_CMD" -e "s|@WEB_ROOT@|$WEB_ROOT|g;s|@BACKUP_ROOT@|$BACKUP_ROOT|g;s|@XFER_EXTRACTOR_DIR@|$XFER_EXTRACTOR_DIR|g;s|@DEFAULT_LOCALE@|$DEFAULT_LOCALE|g" < "$HOSTINGWIZ_DIR/create.sh.in" > "$HOSTINGWIZ_DIR/create.sh" && chmod u+x "$HOSTINGWIZ_DIR/create.sh"

### Substitute at 'awstats-rotat.tmpl' ###
"$SED_CMD" -e "s|@DATE_CMD@|$DATE_CMD|g" < "$HOSTINGWIZ_DIR/awstats-rotat.tmpl.in" > "$HOSTINGWIZ_DIR/awstats-rotat.tmpl"

# Use MySQL
DEFAULT="y"
QUESTION="Must MySQL scripts be configured [y/n]"
VALUE="x"

while [ ! "$VALUE" = "y" -a ! "$VALUES" = "yes" -a ! "$VALUE" = "n" -a ! "$VALUE" = "no" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
USE_MYSQL="$VALUE"

if [ "$USE_MYSQL" = "y" -o "$USE_MYSQL" = "yes" ]; then
	# mysqladmin
	DEFAULT=`which mysqladmin`
	QUESTION="Path to mysqladmin command"
	VALUE="x"

	while [ ! -x "$VALUE" ]; do
        	echo "$QUESTION (default: $DEFAULT): "
	        read VALUE

        	if [ "$VALUE" = "" ]; then
                	VALUE="$DEFAULT"
	        fi
	done
	MYSQLADM_CMD="$VALUE"

	# mysql
	DEFAULT=`which mysql`
	QUESTION="Path to mysql command"
	VALUE="x"

	while [ ! -x "$VALUE" ]; do
        	echo "$QUESTION (default: $DEFAULT): "
	        read VALUE

	        if [ "$VALUE" = "" ]; then
        	        VALUE="$DEFAULT"
	        fi
	done
	MYSQL_CMD="$VALUE"

	# mysql super-user
	DEFAULT="root"
	QUESTION="Path to mysql super-user name"
	VALUE=""

	while [ "$VALUE" = "" ]; do
        	echo "$QUESTION (default: $DEFAULT): "
	        read VALUE

        	if [ "$VALUE" = "" ]; then
                	VALUE="$DEFAULT"
	        fi
	done
	MYSQLSU="$VALUE"

	# mysql super-pass
	DEFAULT=""
	QUESTION="Path to mysql super-user password"
	VALUE=""

	while [ "$VALUE" = "" ]; do
        	echo "$QUESTION (default: $DEFAULT): "
	        read VALUE

        	if [ "$VALUE" = "" ]; then
                	VALUE="$DEFAULT"
	        fi
	done
	MYSQLSU_PASS="$VALUE"

	### Substitute at 'c-mysql.sh' ###
	"$SED_CMD" -e "s|@MYSQLADM_CMD@|$MYSQLADM_CMD|g;s|@MYSQL_CMD@|$MYSQL_CMD|g;s|@MYSQLSU@|$MYSQLSU|g;s|@MYSQLSU_PASS@|$MYSQLSU_PASS|g" < "$HOSTINGWIZ_DIR/c-mysql.sh.in" > "$HOSTINGWIZ_DIR/c-mysql.sh" && chmod u+x "$HOSTINGWIZ_DIR/c-mysql.sh"

	# mysqldump
	DEFAULT=`which mysqldump`
	QUESTION="Path to mysqldump command"
	VALUE="x"

	while [ ! -x "$VALUE" ]; do
        	echo "$QUESTION (default: $DEFAULT): "
	        read VALUE

        	if [ "$VALUE" = "" ]; then
                	VALUE="$DEFAULT"
	        fi
	done
	MYSQLDUMP_CMD="$VALUE"

	### Substitute at 'backup-mysql.tmpl' ###
	"$SED_CMD" -e "s|@HOSTINGWIZ_DIR@|$HOSTINGWIZ_DIR|g;s|@MYSQLDUMP_CMD@|$MYSQLDUMP_CMD|g;s|@DATE_CMD@|$DATE_CMD|g" < "$HOSTINGWIZ_DIR/backup-mysql.tmpl.in" > "$HOSTINGWIZ_DIR/backup-mysql.tmpl"

	# phpMyAdmin
	DEFAULT="/usr/share/phpMyAdmin"
	QUESTION="Path to phpMyAdmin directory"
	VALUE="x"

	while [ ! -d "$VALUE" ]; do
	        echo "$QUESTION (default: $DEFAULT): "
        	read VALUE

	        if [ "$VALUE" = "" ]; then
        	        VALUE="$DEFAULT"
	        fi
	done
	PHPMYADM_DIR="$VALUE"
fi

# Use PostgreSQL
DEFAULT="y"
QUESTION="Must PostgreSQL scripts be configured [y/n]"
VALUE="x"

while [ ! "$VALUE" = "y" -a ! "$VALUES" = "yes" -a ! "$VALUE" = "n" -a ! "$VALUE" = "no" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
USE_PGSQL="$VALUE"

if [ "$USE_PGSQL" = "y" -o "$USE_PGSQL" = "yes" ]; then
	# pgdump
	DEFAULT=`which pg_dump`
	QUESTION="Path to pg_dump command"
	VALUE="x"

	while [ ! -x "$VALUE" ]; do
        	echo "$QUESTION (default: $DEFAULT): "
	        read VALUE

        	if [ "$VALUE" = "" ]; then
	                VALUE="$DEFAULT"
	        fi
	done
	PGDUMP_CMD="$VALUE"

	### Substitute at 'backup-pgsql.tmpl' ###
	"$SED_CMD" -e "s|@HOSTINGWIZ_DIR@|$HOSTINGWIZ_DIR|g;s|@PGDUMP_CMD@|$PGDUMP_CMD|g;s|@DATE_CMD@|$DATE_CMD|g" < "$HOSTINGWIZ_DIR/backup-pgsql.tmpl.in" > "$HOSTINGWIZ_DIR/backup-pgsql.tmpl"

	# psql
	DEFAULT=`which psql`
	QUESTION="Path to psql command"
	VALUE="x"

	while [ ! -x "$VALUE" ]; do
        	echo "$QUESTION (default: $DEFAULT): "
	        read VALUE

        	if [ "$VALUE" = "" ]; then
                	VALUE="$DEFAULT"
	        fi
	done
	PGSQL_CMD="$VALUE"

	### Substitute at 'c-pgsql.sh' ###
	"$SED_CMD" -e "s|@PGSQL_CMD@|$PGSQL_CMD|g" < "$HOSTINGWIZ_DIR/c-pgsql.sh.in" > "$HOSTINGWIZ_DIR/c-pgsql.sh" && chmod u+x "$HOSTINGWIZ_DIR/c-pgsql.sh"

	# phpPgAdmin
	DEFAULT="/usr/share/phpPgAdmin"
	QUESTION="Path to phpPgAdmin directory"
	VALUE="x"

	while [ ! -d "$VALUE" ]; do
	        echo "$QUESTION (default: $DEFAULT): "
        	read VALUE

	        if [ "$VALUE" = "" ]; then
        	        VALUE="$DEFAULT"
	        fi
	done
	PHPPGADM_DIR="$VALUE"
fi

# Vhost dir
DEFAULT="/etc/httpd/conf/vhosts"
QUESTION="Path to vhosts configuration directory"
VALUE="x"

while [ ! -d "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
VHOST_DIR="$VALUE"

# Vhost file extension
DEFAULT="vhost"
QUESTION="Vhost file extension"
VALUE=""

echo "$QUESTION (default: .$DEFAULT): "
read VALUE

if [ "$VALUE" = "" ]; then
    VALUE="$DEFAULT"
fi

VHOST_FEXT="$VALUE"

# ifconfig
DEFAULT=`which ifconfig`
QUESTION="Path to ifconfig command"
VALUE="x"

while [ ! -x "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
IFCFG_CMD="$VALUE"

# iface
DEFAULT="eth0:0"
QUESTION="Public network interface"
VALUE=""

while [ "$VALUE" = "" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
HOSTING_IFACE="$VALUE"

### Substitute at 'c-vhost.sh' ###
"$SED_CMD" -e "s|@VHOST_DIR@|$VHOST_DIR|g;s|@PHPMYADM_DIR@|$PHPMYADM_DIR|g;s|@PHPPGADM_DIR@|$PHPPGADM_DIR|g;s|@IFCFG_CMD@|$IFCFG_CMD|g;s|@HOSTING_IFACE@|$HOSTING_IFACE|g" < "$HOSTINGWIZ_DIR/c-vhost.sh.in" > "$HOSTINGWIZ_DIR/c-vhost.sh" && chmod u+x "$HOSTINGWIZ_DIR/c-vhost.sh"

### Substitute at 'apache-vhost.tmpl.in' ###
"$SED_CMD" -e "s|@AWSTATS_WEBDIR@|$AWSTATS_WEBDIR|g;s|@AWSTATS_CGIDIR@|$AWSTATS_CGIDIR|g" < "$HOSTINGWIZ_DIR/apache-vhost.tmpl.in" > "$HOSTINGWIZ_DIR/apache-vhost.tmpl"

# servername
DEFAULT=`hostname | cut -d '.' -f 1`
QUESTION="Server name"
VALUE=""

while [ "$VALUE" = "" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
SERVERNAME="$VALUE"

# rsync secret
DEFAULT="/etc/backup.d/rsync.secret"
QUESTION="Path to rsync secret file"
VALUE="x"

while [ ! -f "$VALUE" -o ! -r "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
RSYNC_SECRET="$VALUE"

# rsync command
DEFAULT=`which rsync`
QUESTION="Path to rsync command"
VALUE="x"

while [ ! -x "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
RSYNC_CMD="$VALUE"

### Substitute at 'rsync.tmpl' ###
"$SED_CMD" -e "s|@SERVERNAME@|$SERVERNAME|g;s|@RSYNC_SECRET@|$RSYNC_SECRET|g;s|@RSYNC_CMD@|$RSYNC_CMD|g" < "$HOSTINGWIZ_DIR/rsync.tmpl.in" > "$HOSTINGWIZ_DIR/rsync.tmpl"

# cron daily
DEFAULT="/etc/cron.daily"
QUESTION="Path to cron.daily directory"
VALUE="x"

while [ ! -d "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
CRON_DAILY_DIR="$VALUE"

### Substitute at 'c-rsync.sh' ###
"$SED_CMD" -e "s|@CRON_DAILY_DIR@|$CRON_DAILY_DIR|g" < "$HOSTINGWIZ_DIR/c-rsync.sh.in" > "$HOSTINGWIZ_DIR/c-rsync.sh" && chmod u+x "$HOSTINGWIZ_DIR/c-rsync.sh"

# Unzip
DEFAULT=`which unzip`
QUESTION="Path to unzip command"
VALUE="x"

while [ ! -x "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
UNZIP_CMD="$VALUE"

# Zip
DEFAULT=`which zip`
QUESTION="Path to zip command"
VALUE="x"

while [ ! -x "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
ZIP_CMD="$VALUE"

# OpenDoc templates dir
DEFAULT="/usr/share/nozicaa-odt"
QUESTION="Path to OpenDoc templates directory"
VALUE="x"

while [ ! -d "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
ODF_TMPL_DIR="$VALUE"

# Report output dir
DEFAULT="/tmp"
QUESTION="Path to report generation output directory"
VALUE="x"

while [ ! -d "$VALUE" ]; do
        echo "$QUESTION (default: $DEFAULT): "
        read VALUE

        if [ "$VALUE" = "" ]; then
                VALUE="$DEFAULT"
        fi
done
REPORT_OUTPUTDIR="$VALUE"

### Substitute at 'c-report.sh' ###
"$SED_CMD" -e "s|@FIND_CMD@|$FIND_CMD|g;s|@SED_CMD@|$SED_CMD|g;s|@UNZIP_CMD@|$UNZIP_CMD|g;s|@ZIP_CMD@|$ZIP_CMD|g;s|@ODF_TMPL_DIR@|$ODF_TMPL_DIR|g;s|@REPORT_OUTPUTDIR@|$REPORT_OUTPUTDIR|g" < "$HOSTINGWIZ_DIR/c-report.sh.in" > "$HOSTINGWIZ_DIR/c-report.sh" && chmod u+x "$HOSTINGWIZ_DIR/c-report.sh"

### Substitute at 'r-backup.sh' ###
"$SED_CMD" -e "s|@CRON_DAILY_DIR@|$CRON_DAILY_DIR|g;s|@FIND_CMD@|$FIND_CMD|g" < "$HOSTINGWIZ_DIR/r-backup.sh.in" > "$HOSTINGWIZ_DIR/r-backup.sh" && chmod u+x "$HOSTINGWIZ_DIR/r-backup.sh"

### Substitute at 'r-user.sh' ###
"$SED_CMD" -e "s|@USERDEL_CMD@|$USERDEL_CMD|g" < "$HOSTINGWIZ_DIR/r-user.sh.in" > "$HOSTINGWIZ_DIR/r-user.sh" && chmod u+x "$HOSTINGWIZ_DIR/r-user.sh"

### Substitute at 'r-awstats.sh' ###
"$SED_CMD" -e "s|@FIND_CMD@|$FIND_CMD|g;s|@AWSTATS_CFGDIR@|$AWSTATS_CFGDIR|g;s|@AWSTATS_PASSWD_FILE@|$AWSTATS_PASSWD_FILE|g" < "$HOSTINGWIZ_DIR/r-awstats.sh.in" > "$HOSTINGWIZ_DIR/r-awstats.sh" && chmod u+x "$HOSTINGWIZ_DIR/r-awstats.sh"

### Substitute at 'r-mysql.sh' ###
if [ "$USE_MYSQL" = "y" -o "$USE_MYSQL" = "yes" ]; then
    "$SED_CMD" -e "s|@MYSQL_CMD@|$MYSQL_CMD|g;s|@MYSQLADM_CMD@|$MYSQLADM_CMD|g;s|@MYSQLSU@|$MYSQLSU|g;s|@MYSQLSU_PASS@|$MYSQLSU_PASS|g" < "$HOSTINGWIZ_DIR/r-mysql.sh.in" > "$HOSTINGWIZ_DIR/r-mysql.sh" && chmod u+x "$HOSTINGWIZ_DIR/r-mysql.sh"
fi

### Substitute at 'r-pgsql.sh' ###
if [ "$USE_PGSQL" = "y" -o "$USE_PGSQL" = "yes" ]; then
    "$SED_CMD" -e "s|@PGSQL_CMD@|$PGSQL_CMD|g" < "$HOSTINGWIZ_DIR/r-pgsql.sh.in" > "$HOSTINGWIZ_DIR/r-pgsql.sh" && chmod u+x "$HOSTINGWIZ_DIR/r-pgsql.sh"
fi

### Substitute at 'remove.sh' ###
"$SED_CMD" -e "s|@WEB_ROOT@|$WEB_ROOT|g;s|@BACKUP_ROOT@|$BACKUP_ROOT|g;s|@VHOST_DIR@|$VHOST_DIR|g;s|@VHOST_FEXT@|$VHOST_FEXT|g;s|@FIND_CMD@|$FIND_CMD|g;s|@SED_CMD@|$SED_CMD|g;s|@XFER_EXTRACTOR_DIR@|$XFER_EXTRACTOR_DIR|g" < "$HOSTINGWIZ_DIR/remove.sh.in" > "$HOSTINGWIZ_DIR/remove.sh" && chmod u+x "$HOSTINGWIZ_DIR/remove.sh"

### Date library ###
chown `whoami` $HOSTINGWIZ_DIR/date/*.sh
chmod u+x $HOSTINGWIZ_DIR/date/*.sh
