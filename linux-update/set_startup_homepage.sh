#!/bin/bash

# firefox
# http://askubuntu.com/questions/73474/how-to-install-firefox-addon-from-command-line-in-scripts
for user_name in `ls /home/`
do
  preferences_file="`echo /home/$user_name/.mozilla/firefox/*.default/prefs.js`"
  if [ -f "$preferences_file" ]
  then
    echo "user_pref(\"browser.startup.homepage\", \"https://coderdojopotsdam.github.io/\");" >> $preferences_file
  fi
done

# opera
python3 -c 'import json
import os
for user_name in os.listdir("/home/"):
  preferences_file = "/home/{}/.config/opera/Preferences".format(user_name)
  if os.path.isfile(preferences_file):
    with open(preferences_file) as file:
      preferences = json.load(file)
    preferences["session"] = {
        "restore_on_startup":4,
        "startup_urls":["https://coderdojopotsdam.github.io/"],
        "urls_signature":"XunzeXhkToGKRY1+Zf98KY0skksrNYV2vciHYl4IKwI2De5OKDgrUU1Z5Q4UB8vo"
      }
    with open(preferences_file, "w") as file:
      json.dump(preferences, file)
'
