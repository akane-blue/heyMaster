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
echo "[${COMMITHASH}] でっぷろーい！" | toot
docker-compose up -d

while true; do
        DonAlive=$(curl -s -o /dev/null -I -w "%{http_code}\n" https://mstdn.maud.io/)
        if [ $DonAlive -eq 302 ]; then
                break
        fi
                echo "しっぱい… 5s後に再試行するよ"
                sleep 5s
done

echo "[${COMMITHASH}] だん!" | toot

