#!/bin/sh

set -v

now=$(date +%Y%m%d-%H%M%S)

analyze_access="sudo alp json --file /var/log/nginx/access.log -r --sort=avg -m \"/image/[0-9]+.(jpg|png|gif), /@[a-zA-Z]+, /posts/[0-9]+\""
analyze_slow_query="sudo pt-query-digest /var/log/mysql/mysql-slow.log"

ssh -i isucon.pem isucon@54.238.8.136 "$analyze_access" | tee logs/nginx/digest.log.$now
ssh -i isucon.pem isucon@54.238.8.136 "$analyze_slow_query" | tee logs/mysql/digest.log.$now

# rsync -v -i isucon.pem isucon@52.195.180.147:/home/isucon/profile.pb.gz logs/pprof/profile.pb.gz.$now
# go tool pprof -http=localhost:6060 logs/pprof/profile.pb.gz.$now