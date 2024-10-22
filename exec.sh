#!/bin/sh

set -v

pprof="/usr/local/go/bin/go tool pprof -proto -seconds 60 -output profile.pb.gz http://localhost:6060/debug/pprof/profile"
benchmark="/home/isucon/private_isu.git/benchmarker/bin/benchmarker -u /home/isucon/private_isu.git/benchmarker/userdata -t http://172.31.15.216"

ssh -i isucon.pem isucon@54.238.8.136 "$pprof" &
ssh -i isucon.pem isucon@54.238.8.136 "$benchmark"