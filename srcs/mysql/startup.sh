mysql_install_db --user=mysql --ldata=/var/lib/mysql

# allow local dbg
echo "GRANT ALL ON *.* TO '${DB_USER}'@'127.0.0.1' IDENTIFIED BY '${DB_PASS}' WITH GRANT OPTION;" > /tmp/sql
echo "GRANT ALL ON *.* TO '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}' WITH GRANT OPTION;" >> /tmp/sql

# allow external connections
echo "GRANT ALL ON *.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}' WITH GRANT OPTION;" >> /tmp/sql
# echo "GRANT ALL ON *.* TO ${DB_USER}@'::1' IDENTIFIED BY '${DB_PASS}' WITH GRANT OPTION;" >> /tmp/sql
echo "SET PASSWORD FOR '$DB_USER'@'localhost'=PASSWORD('${DB_PASS}') ;"
echo "DELETE FROM mysql.user WHERE User='';" >> /tmp/sql
# echo "DROP DATABASE test;" >> /tmp/sql
echo "FLUSH PRIVILEGES;" >> /tmp/sql

cat /tmp/sql
echo ""
cat /etc/my.cnf

export MYSQL_HOME=/etc/

# /usr/bin/mysqld --user=mysql --console --socket=/var/lib/mysql/mysql.sock --skip-name-resolve --skip-networking=0 --init_file=/tmp/sql
/usr/bin/mysqld --user=mysql --console --init_file=/tmp/sql