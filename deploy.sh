#!/bin/sh

ssh -o StrictHostKeyChecking=no ubuntu@$DEV_HOST << 'ENDSSH'
  set -e
  cd /home/chonagiau/ch-nha-giau/
  git pull origin dev
  exec "$@"
ENDSSH
