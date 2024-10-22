#!/bin/sh
# referenced from https://github.com/tatsuru/isucon13/blob/main/scripts/deploy

set -v

now=$(date +%Y%m%d-%H%M%S)
branch=${1-master}

update="cd /home/isucon/private_isu && git remote update && git checkout $branch && git pull"
restart="cd /home/isucon/private_isu/webapp/golang && /usr/local/go/bin/go build -o app && sudo systemctl restart isu-go"
rotate_mysql="sudo rm /var/log/mysql/mysql-slow.log && mysqladmin -uisuconp -pisuconp flush-logs"
rotate_nginx="sudo rm /var/log/nginx/access.log && sudo systemctl reload nginx"

git push origin $branch
ssh -i isucon.pem isucon@54.238.8.136 "$update && $restart && $rotate_mysql && $rotate_nginx"