import os
from subprocess import run as srun
UPSTREAM_REPO ="https://github.com/tonmoyislam12/aria-telegram-mirror-bot"
UPSTREAM_BRANCH ="main"

srun([f"git init -q \
&& git config --global user.email merrydith52829@hotmail.com \
&& git config --global user.name tonmoyislam12 \
&& git add . \
&& git commit -sm update -q \
&& git remote add origin {UPSTREAM_REPO} \
&& git fetch origin -q \
&& git reset --hard origin/{UPSTREAM_BRANCH} -q"], shell=True)
