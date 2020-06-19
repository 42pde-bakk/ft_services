#!/bin/bash

let ret=1
while :
do
	kubectl apply -k ./srcs 2>/dev/null
	if [ $? == 0 ]
	then
		break
	fi
	# sleep 1
done
