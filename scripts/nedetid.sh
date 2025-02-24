#!/bin/bash

source /home/ubuntu/scripts/base.sh

if [ "$1" = "ned" ]; then
	info "Bytter endpoint til manager og går ned"
	uc set endpoint 10.212.173.164
elif [ "$1" = "opp" ]; then
	info "Bytter endpoint til balancer og går opp"
	uc set endpoint 10.212.172.50
else
	error "Feil argument"
fi
