#!/bin/bash
# Last Update : 2012/04/20
# Author      : labunix
# Description : Please Check and set variable. 
#               RHOST,RPORT,RUSER,RPASS
#               
set -e
if [ "x${PATH}" == "x" ];then
  echo "ERROR:empty PATH"
  exit 1
fi
echo $PATH | sed s/":"/"\n"/g | grep "^/sbin\$" || \
  export PATH=/sbin:${PATH}
echo $PATH | sed s/":"/"\n"/g | grep "^/usr/sbin\$" || \
  export PATH=/usr/sbin:${PATH}

FDATE=`date '+%Y/%m/%d %H:%M'`
RHOST=`hostname -s`
RPORT=21
RUSER=anonymouse
RPASS=`whoami`@`hostname -f`

echo $FDATE | tee -a $0.log
(sleep 1; echo "open ${RHOST} ${RPORT}";
 sleep 1; echo "user ${RUSER} ${RPASS}";
 sleep 1; echo "prompt"
 sleep 1; echo "cd logs"
 sleep 1; echo "mput *"
 sleep 1; echo "bye"
 sleep 1; echo "quit"
 sleep 1; echo; ) | ftp -n -v | tee -a $0.log

FLAG=$?
unset FDATE
unset RHOST
unset RPORT
unset RUSER
unset RPASS
unset PATH
if [ "$FLAG" -ne 0 ];then
  echo "Error, Please Check $0.log"
else
  echo "Success!"
fi
unset FLAG
exit 0
