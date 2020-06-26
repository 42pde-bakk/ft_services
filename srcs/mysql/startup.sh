#!/bin/sh

# parameters
MYSQL_ROOT_PWD=${MYSQL_ROOT_PWD}
MYSQL_USER=${MYSQL_USER}
MYSQL_USER_PWD=${MYSQL_USER_PWD}
MYSQL_USER_DB=${MYSQL_USER_DB}

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ -d /var/lib/mysql/mysql ]; then
	echo '[i] MySQL directory already present, skipping creation'
else
	echo "[i] MySQL data directory not found, creating initial DBs"

	chown -R mysql:mysql /var/lib/mysql

	# init database
	echo 'Initializing database'
	mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
	echo 'Database initialized'

	chown -R mysql:mysql /var/lib/mysql

	echo "[i] MySql root password: $MYSQL_ROOT_PWD"

	# create temp file
	tfile=`mktemp`
	if [ ! -f "$tfile" ]; then
	    return 1
	fi

	# save sql
	echo "[i] Create temp file: $tfile"
	cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PWD' WITH GRANT OPTION;
EOF

	# Create new database
	if [ "$MYSQL_USER_DB" != "" ]; then
		echo "[i] Creating database: $MYSQL_USER_DB"
		echo "CREATE DATABASE $MYSQL_USER_DB CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile

		# set new User and Password
		if [ "$MYSQL_USER" != "" ] && [ "$MYSQL_USER_PWD" != "" ]; then
		echo "[i] Creating user: $MYSQL_USER with password $MYSQL_USER_PWD"
		# echo "DROP USER IF EXISTS '$MYSQL_USER'@'localhost';" >> $tfile
		echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PWD';" >> $tfile
		echo "GRANT ALL ON $MYSQL_USER_DB.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PWD' WITH GRANT OPTION;" >> $tfile
		fi
	else
		# don`t need to create new database,Set new User to control all database.
		if [ "$MYSQL_USER" != "" ] && [ "$MYSQL_USER_PWD" != "" ]; then
		echo "[i] Creating user: $MYSQL_USER with password $MYSQL_USER_PWD"
		# echo "DROP USER IF EXISTS '$MYSQL_USER'@'localhost';" >> $tfile
		echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PWD';" >> $tfile
		echo "GRANT ALL PRIVILEGES ON *.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PWD';" >> $tfile
		fi
	fi

	echo 'FLUSH PRIVILEGES;' >> $tfile

	# run sql in tempfile
	echo "[i] run tempfile: $tfile"
	/usr/bin/mysqld --user=mysql --datadir=/var/lib/mysql --bootstrap --verbose=0 < $tfile
	rm -f $tfile
fi

echo "[i] Sleeping 5 sec"
sleep 5

echo '[i] start running mysqld'
exec /usr/bin/mysqld --user=mysql --datadir=/var/lib/mysql --console






# #!/bin/sh

# if [ ! -d "/run/mysqld" ]; then
#   mkdir -p /run/mysqld
# fi

# if [ -d /app/mysql ]; then
#   echo "[i] MySQL directory already present, skipping creation"
# else
#   echo "[i] MySQL data directory not found, creating initial DBs"

#   mysql_install_db --user=root > /dev/null

#   # if [ "$MYSQL_ROOT_PASSWORD" = "" ]; then
#   #   MYSQL_ROOT_PASSWORD=111111
#   #   echo "[i] MySQL root Password: $MYSQL_ROOT_PASSWORD"
#   # fi
#   echo "[i] MySql root password: $MYSQL_ROOT_PWD"

#   MYSQL_DATABASE=${MYSQL_DATABASE:-""}
#   MYSQL_USER=${MYSQL_USER:-""}
#   MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}

#   tfile=`mktemp`
#   if [ ! -f "$tfile" ]; then
#       return 1
#   fi

#   cat << EOF > $tfile
# USE mysql;
# FLUSH PRIVILEGES;
# GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY "$MYSQL_ROOT_PASSWORD" WITH GRANT OPTION;
# GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
# ALTER USER 'root'@'localhost' IDENTIFIED BY '';
# EOF

#   if [ "$MYSQL_DATABASE" != "" ]; then
#     echo "[i] Creating database: $MYSQL_DATABASE"
#     echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile

#     if [ "$MYSQL_USER" != "" ]; then
#       echo "[i] Creating user: $MYSQL_USER with password $MYSQL_PASSWORD"
#       echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
#     fi
#   fi

#   /usr/bin/mysqld --user=root --bootstrap --verbose=0 < $tfile
#   rm -f $tfile
# fi


# exec /usr/bin/mysqld --user=root --console
