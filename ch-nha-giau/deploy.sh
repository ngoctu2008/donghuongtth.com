#!/bin/sh

ssh -o StrictHostKeyChecking=no $SSH_USER@$DEV_HOST << 'ENDSSH'
  set -e
  cd /home/chonhagiau/ch-nha-giau/
  git pull origin dev
  exec "$@"
ENDSSH
