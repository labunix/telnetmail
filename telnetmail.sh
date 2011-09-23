#!/bin/sh -x

TDATE=`date '+%Y/%m/%d %H:%M'`
THOST=`hostname -s`
PORT=25

FFQDN=`hostname -f`
FUSER=`whoami`

RFQDN=$2
RUSER=$1

(sleep 1; echo "EHLO ${THOST}";
sleep 1; echo "MAIL FROM: ${FUSER}@${FFQDN}";
sleep 1; echo "RCPT TO: ${RUSER}@${RFQDN}";
sleep 1; echo "DATA"
sleep 1; echo "From: MAIL ${FUSER} <${FUSER}@${FFQDN}>"
echo "Subject: mail from ${FUSER}"
echo "To: MAIL <${RUSER}@${RFQDN}>"
echo "${TDATE}"
echo "."
sleep 1; echo "QUIT"
sleep 1; echo; ) | telnet $THOST $PORT

