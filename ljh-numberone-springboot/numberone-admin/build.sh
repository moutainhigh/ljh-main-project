#!/bin/sh

docker rmi -f 192.168.85.30:81/ljc555/ljh-numberone-springboot:1.0

docker build -t 192.168.85.30:81/ljc555/ljh-numberone-springboot:1.0 .

docker push 192.168.85.30:81/ljc555/ljh-numberone-springboot:1.0
