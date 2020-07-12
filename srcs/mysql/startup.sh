mysql_install_db --user=mysql --ldata=/var/lib/mysql

# allow local dbg

:> /tmp/sql
# allow external connections
echo "Ik maak nu Database $DB_NAME aan. poggers"
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;" >> /tmp/sql
echo "krijg de kanker"
echo "SET PASSWORD FOR '$DB_USER'@'localhost'=PASSWORD('${DB_PASS}') ;" >> /tmp/sql
echo "GRANT ALL ON *.* TO '$DB_USER'@'127.0.0.1' IDENTIFIED BY '$DB_PASS' WITH GRANT OPTION;" >> /tmp/sql
echo "GRANT ALL ON *.* TO '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS' WITH GRANT OPTION;" >> /tmp/sql
echo "GRANT ALL ON *.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS' WITH GRANT OPTION;" >> /tmp/sql
# echo "GRANT ALL ON *.* TO $DB_USER@'::1' IDENTIFIED BY '${DB_PASS}' WITH GRANT OPTION;" >> /tmp/sql
# echo "DELETE FROM mysql.user WHERE User='';" >> /tmp/sql
echo "FLUSH PRIVILEGES;" >> /tmp/sql

# cat /tmp/sql
# echo ""
# cat /etc/my.cnf

/usr/bin/mysqld --console --init_file=/tmp/sql
echo "test voor na mysqld"
# mysql service start