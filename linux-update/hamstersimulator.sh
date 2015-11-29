#!/bin/bash

# start the hamstersimulator

log_file=/tmp/hamstersimulator.log

for java_version in `ls /opt/hamstermodell`
do
  if java -version 2>&1 | grep -q "java version \"$java_version"
  then
    # found the folder with the java version
    jar_file=`find /opt | grep 'hamstersimulator.jar' | head -n1`
    if [ "$jar_file" == "" ]
    then
      rm -f "/opt/hamstermodell/$java_version/VERSION"
      notify-send "Could not find hamstersimulator.jar for java version $java_version"
    fi
    # start the simulator and measure time
    cd "`dirname $jar_file`"

    # fill the log file    
    echo ----------------------------------- >> $log_file
    echo java_version: $java_version
    java -version 2>> $log_file 1>> $log_file

    # measure time from http://stackoverflow.com/a/22517555
    start_time=$(date -u +"%s")
    java -jar "$jar_file" 2>>$log_file 1>>$log_file
    end_time=$(date -u +"%s")
    # compare from http://stackoverflow.com/a/18668580
    if (( start_time + 7 > end_time ))
    then
      notify-send "Could not start the Hamstersimulator. See $log_file for more information or run java -jar \"$jar_file\"."
    fi
  fi
done
