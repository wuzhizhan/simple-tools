#!/bin/sh
##
#tomcat 指定用户启动脚本，解决tomcat不能非root启动问题
##
#设置tomcat的根目录，否则用当前目录
TOMCAT_HOME=
cur_dir=$(cd "$(dirname "$0")"; pwd)
parent_dir=$(dirname $cur_dir)
if [ -z "$TOMCAT_HOME" ]
then
	TOMCAT_HOME=$parent_dir
fi
echo $TOMCAT_HOME

sudo chown -R tomcat:tomcat $TOMCAT_HOME/logs
sudo chown -R tomcat:tomcat $TOMCAT_HOME/temp
sudo chown -R tomcat:tomcat $TOMCAT_HOME/work
sudo chown -R tomcat:tomcat $TOMCAT_HOME/conf
sudo chown -R tomcat:tomcat $TOMCAT_HOME/webapps
case "$1" in
    start)
	su -m - tomcat $TOMCAT_HOME/bin/startup.sh
	;;
    stop)
        su -m - tomcat $TOMCAT_HOME/bin/shutdown.sh
	;;
    restart)
	su -m - tomcat $TOMCAT_HOME/bin/shutdown.sh
	echo "begin start....."
	sleep 3
	su -m - tomcat $TOMCAT_HOME/bin/startup.sh
	;;
     *)
	echo "Usage:{start|stop|restart}" >&2
	exit 1
esac
exit 0
