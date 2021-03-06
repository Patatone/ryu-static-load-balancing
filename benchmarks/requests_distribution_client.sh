#!/bin/bash

if [ "$#" -ne 3 ]; then 
    echo "$0 <CLIENT_NAME> <SERVER_IP> <REQUEST_NUMBER>"
	echo "$0 h1 10.0.1.3 100"
    exit 1
fi

#2 because one request is the HEAD request
i=2
start=$(date +%s)
while [ "$i" -le "$3" ]; do
  /home/vagrant/mininet/util/m "$1" curl -silent --output /dev/null "$2"
  i=$(($i + 1))
done

#Last request
/home/vagrant/mininet/util/m "$1" curl -silent --output /dev/null -X HEAD "$2"
end=$(date +%s)
runtime=$( echo "$end - $start" | bc -l )

echo Sent "$3" packets in "$runtime" seconds