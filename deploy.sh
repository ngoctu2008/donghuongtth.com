#!/bin/sh

ssh -o StrictHostKeyChecking=no $SSH_USER@$DEV_HOST << 'ENDSSH'
  set -e
  cd /home/chonhagiau/ch-nha-giau/
  rm -Rf src/data/logs/ref_logs/tmp.log
  git pull origin dev
  chown chonhagiau:chonhagiau /home/chonhagiau/ch-nha-giau/src
  chmod -R 777 /home/chonhagiau/ch-nha-giau/src
  chown chonhagiau:chonhagiau -Rf /home/chonhagiau/ch-nha-giau/src/*
  cd /home/chonhagiau/ch-nha-giau/src/
  chmod -Rf 755 ./*
  find ./ -type f -exec chmod 644 {} +;
  chmod 777 /home/chonhagiau/ch-nha-giau/src/.htaccess
  #cd /home/chonhagiau/chonhagiau.com
  #git pull origin master
  #chown chonhagiau:chonhagiau /home/chonhagiau/chonhagiau.com/src
  #chmod -R 777 /home/chonhagiau/chonhagiau.com/src
  #chown chonhagiau:chonhagiau -Rf /home/chonhagiau/chonhagiau.com/src/*
  #cd /home/chonhagiau/chonhagiau.com/src/
  #chmod -Rf 755 ./*
  #find ./ -type f -exec chmod 644 {} +;
  #chmod 777 /home/chonhagiau/chonhagiau.com/src/.htaccess
  cd /home/chonhagiau/public_html
  rm -Rf data/logs/ref_logs/tmp.log
  git pull origin master
  chown chonhagiau:chonhagiau /home/chonhagiau/public_html
  chmod -R 777 /home/chonhagiau/public_html
  chown chonhagiau:chonhagiau -Rf /home/chonhagiau/public_html/*
  cd /home/chonhagiau/public_html/
  chmod -Rf 755 ./*
  find ./ -type f -exec chmod 644 {} +;
  chmod 777 /home/chonhagiau/public_html/.htaccess
  exec "$@"
ENDSSH
