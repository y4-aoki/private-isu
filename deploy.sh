#!/bin/sh
# referenced from https://github.com/tatsuru/isucon13/blob/main/scripts/deploy

set -v

now=$(date +%Y%m%d-%H%M%S)
branch=${1-master}

update="cd /home/isucon/private_isu && git remote update && git checkout $branch && git pull"
restart="cd /home/isucon/private_isu/webapp/golang && /usr/local/go/bin/go build -o app && sudo systemctl restart isu-go"
rotate_mysql="sudo mv -v /var/log/mysql/slow.log /var/log/mysql/slow.log.$now && mysqladmin -uisuconp -pisuconp flush-logs"
rotate_nginx="sudo mv -v /var/log/nginx/access.log /var/log/nginx/access.log.$now && sudo systemctl reload nginx"

git push origin $branch
ssh -i isucon.pem isucon@52.195.180.147 "$update && $restart && $rotate_mysql && $rotate_nginx"