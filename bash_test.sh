#!/bin/bash

ip address | grep "inet " | grep lo | awk '{ print $2 }' | cut -c 1-9
ip address | grep "inet " | grep enp0s3 | awk '{ print $2 }' | cut -c 1-9
ip address | grep "inet " | grep docker0 | awk '{ print $2 }' | cut -c 1-9
