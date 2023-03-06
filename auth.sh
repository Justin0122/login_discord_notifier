#!/bin/bash

# get the timestamp
timestamp=$(date +%Y-%m-%d_%H:%M:%S)

#check if login_attempts file exists, if not create it. if it does, check the value and increment it by 1
if [ ! -f /var/tmp/failed_login ]; then
  echo "1" > /var/tmp/failed_login
else
  value=$(cat /var/tmp/failed_login)
  value=$((value+1))
  echo $value > /var/tmp/failed_login
fi


# send a message through Discord webhook
send_discord_message() {
  local url="[your discord webhook url]"
  local data=$(cat <<EOF
{
  "username": "Laptop Security",
  "content": "An incorrect password was entered on $timestamp."
}
EOF
)
  curl -H "Content-Type: application/json" -d "$data" "$url"
  #send the images
  for i in {1..2}
  do
    fswebcam --save /var/tmp/failed_login+$i.jpg
    sleep 0.2
    curl -F "file=@/var/tmp/failed_login+$i.jpg" "$url"
  done
}

# check if the value is greater than 2 or equal to 2. This is set to 2 because for some reason the script runs once before the first login attempt (when you're on the login screen)
if [ $value -ge 2 ]; then
  # send the message
  send_discord_message
  # delete the file
  rm /var/tmp/failed_login
fi