#!/bin/bash

COMMITHASH=$(git ls-remote https://github.com/lindwurm/mastodon.git HEAD | head -c 7)
cd mastodon
echo "[${COMMITHASH}] へいますたー！" | toot
git pull
echo "[${COMMITHASH}] びるど！" | toot
docker-compose build
docker-compose run --rm web rails db:migrate
echo "[${COMMITHASH}] ぷりこんぱいる？" | toot
docker-compose run --rm web rails assets:precompile
echo "[${COMMITHASH}] 準備できたよ！" | toot
