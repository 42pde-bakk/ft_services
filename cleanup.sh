# Colors
Color_Off='\033[0m'       # Text Reset
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

echo "${Yellow}---------------------------- Secret ------------------------------${Color_Off}"
kubectl delete secrets
kubectl delete pvc --all --grace-period=0 --force 
echo "\n"

echo "${Yellow}---------------------------- Nginx ------------------------------${Color_Off}"
kubectl delete services nginx
kubectl delete deployment nginx
kubectl delete configMaps/nginx-config
echo "\n"

echo -e "${Yellow}--------------------------- Mysql -------------------------------${Color_Off}"
kubectl delete deployment/mysql
kubectl delete services/mysql
kubectl delete configMaps/mysql-config
# kubectl delete pvc/mysql-pv-claim
echo "\n"

echo "${Yellow}-------------------------- Wordpress ---------------------------${Color_Off}"
kubectl delete deployment/wordpress
kubectl delete services wordpress
kubectl delete configMaps/wordpress-config
# kubectl delete pvc/wordpress-pv-claim
echo "\n"

echo "${Yellow}------------------------- Phpmyadmin ----------------------------${Color_Off}"
kubectl delete deployment/phpmyadmin
kubectl delete service/phpmyadmin
# kubectl delete pvc/phpmyadmin-pv-claim
kubectl delete configMaps/phpmyadmin-config
echo "\n"

echo -e "${Yellow}-------------------------- Grafana ------------------------------${Color_Off}"
kubectl delete deployment/grafana
kubectl delete service/grafana
kubectl delete configMaps/grafana-config
echo "\n"

echo -e "${Yellow}-------------------------- InfluxDB -----------------------------${Color_Off}"
kubectl delete deployment/influxdb
kubectl delete service/influxdb
kubectl delete configMaps/influxdb-config

# kubectl delete pvc/influxdb-pvc
echo "\n"

echo -e "${Yellow}-------------------------- Telegraf -----------------------------${Color_Off}"
kubectl delete deployment/telegraf
kubectl delete service/telegraf
kubectl delete configmap/telegraf-config
echo "\n"

echo "${Green}Cluster cleaned${Color_Off}"
