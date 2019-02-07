#!/bin/bash

COMMITHASH=$(git ls-remote https://github.com/lindwurm/mastodon.git HEAD | head -c 7)
cd mastodon
echo "[${COMMITHASH}] でっぷろーい！" | toot
sleep 5s
docker-compose up -d --remove-orphans

while true; do
    DonAlive=$(curl -s -o /dev/null -I -w "%{http_code}\n" https://mstdn.maud.io/)
    if [ $DonAlive -eq 302 ]; then
        break
    fi
        echo "しっぱい… 5s後に再試行するよ"
        sleep 5s
done

echo "[${COMMITHASH}] だん!" | toot
