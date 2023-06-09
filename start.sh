#!/bin/bash
if [[ -n $DYNO ]]; then

	if [[ -n $GIT_USER && -n $GIT_TOKEN && -n $GIT_REPO ]]; then
		echo "Usage of Service Accounts Detected, Clonning git"
		git clone https://"$GIT_TOKEN"@github.com/"$GIT_USER"/"$GIT_REPO" /bot/app/accounts
		rm -rf /bot/app/accounts/.git
        fi
	if [[ -n $CLIENT_SECRET && -n $CREDENTIALS ]]; then
		echo "Usage of token detected"
		wget -q $CREDENTIALS -O /bot/app/credentials.json
		wget -q $CLIENT_SECRET -O /bot/app/client_secret.json
	else
		echo "Neither Service Accounts Nor Token Provided. Exiting..."
		exit 0
	fi

	if [[ -n $CONSTANTS_URL ]]; then
		wget -q $CONSTANTS_URL -O /bot/app/out/.constants.js
	else
		echo "Provide constants.js to Run the bot. Exiting..."
		exit 0
	fi
fi


if [[ -n $MAX_CONCURRENT_DOWNLOADS ]]; then
	sed -i'' -e "/max-concurrent-downloads/d" $(pwd)/aria.conf
	echo -e "max-concurrent-downloads=$MAX_CONCURRENT_DOWNLOADS" >> $(pwd)/aria.conf
fi

sed -i'' -e "/bt-tracker=/d" $(pwd)/aria.conf
tracker_list=`curl -Ns https://raw.githubusercontent.com/XIU2/TrackersListCollection/master/all.txt | awk '$1' | tr '\n' ',' | cat`
echo -e "bt-tracker=$tracker_list" >> $(pwd)/aria.conf

# Remove the .bak file got created from above sed
test -f $(pwd)/aria.conf-e && rm $(pwd)/aria.conf-e

mrbeast --conf-path=aria.conf
echo "Aria2c daemon started"

# Only start the bot if deployed to heroku, as in local the start command might be different for development
if [[ -n $DYNO ]]; then
	npm start
fi
