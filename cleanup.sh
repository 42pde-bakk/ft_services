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

echo "${Yellow}---------------------------- Secrets ------------------------------${Color_Off}"
kubectl delete secrets
# kubectl delete pvc --all --grace-period=0 --force &

echo "${Yellow}---------------------------- Ftps ------------------------------${Color_Off}"
kubectl delete services ftps-svc
kubectl delete deployment ftps

echo "${Yellow}---------------------------- Nginx ------------------------------${Color_Off}"
kubectl delete services nginx
kubectl delete deployment nginx
kubectl delete configMaps/nginx-config

echo "${Yellow}-------------------------- Wordpress ---------------------------${Color_Off}"
kubectl delete deployment/wordpress-deployment
kubectl delete services wordpress-svc
# kubectl delete configMaps/wordpress-config

echo "${Yellow}------------------------- Phpmyadmin ----------------------------${Color_Off}"
kubectl delete deployment/phpmyadmin-deployment
kubectl delete service/phpmyadmin-svc
# kubectl delete configMaps/phpmyadmin-config

echo "${Yellow}-------------------------- Grafana ------------------------------${Color_Off}"
kubectl delete deployment/grafana
kubectl delete service/grafana-svc
# kubectl delete configMaps/grafana-config

echo "${Yellow}--------------------------- Mysql -------------------------------${Color_Off}"
kubectl delete deployment/mysql
kubectl delete services/mysql
# kubectl delete configMaps/mysql-config

echo "${Yellow}-------------------------- InfluxDB -----------------------------${Color_Off}"
kubectl delete deployment/influxdb-deployment
kubectl delete service/influxdb-svc
# kubectl delete configMaps/influxdb-config

echo "${Yellow}-------------------------- Telegraf -----------------------------${Color_Off}"
kubectl delete deployment/telegraf-deployment
kubectl delete service/telegraf-svc

echo "${Yellow}-------------------------- Clusterroles -----------------------------${Color_Off}"
kubectl delete clusterrole influx:cluster:viewer
kubectl delete clusterrole influx:telegraf
kubectl delete clusterrolebinding influx:telegraf:viewer
kubectl delete role role-rbac
kubectl delete rolebinding rolebinding-rbac

echo "${Green}Cluster cleaned${Color_Off}"