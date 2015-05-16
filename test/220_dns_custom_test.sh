#! /bin/bash

. ./config.sh

C1=10.2.56.34
C2=10.2.54.91
DOMAIN=foo.bar
NAME=seetwo.$DOMAIN

start_suite "Resolve names in custom domain"

weave_on $HOST1 launch-dns 10.2.254.1/24 --domain $DOMAIN.

start_container $HOST1 $C2/24 --name=c2 -h $NAME
weave_on $HOST1 run --with-dns $C1/24 -t --name=c1 aanand/docker-dnsutils /bin/sh

assert_dns_record $HOST1 c1 $NAME $C2

end_suite
