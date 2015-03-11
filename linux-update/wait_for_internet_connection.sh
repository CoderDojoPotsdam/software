#!/bin/sh
# wait for an internet connection

# while loop
# http://bash.cyberciti.biz/guide/While_loop

routesToTheInternet=0

while [ $connections -e 0 ]
do
  # wait some time
  # http://www.unix.com/shell-programming-and-scripting/42396-wait-5-seconds-shell-script.html
  sleep 5

  # check for an internet connection
  # http://stackoverflow.com/questions/1406644/checking-internet-connection-with-command-line-php-on-linux
  routesToTheInternet=`/sbin/route -n | grep -c '^0\.0\.0\.0'`

done
