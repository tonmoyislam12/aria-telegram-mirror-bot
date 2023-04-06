#Base Image
FROM ghcr.io/tonmoyislam12/aria-telegram-mirror-bot:main

WORKDIR /bot/app/

CMD ["bash", "start.sh"]
