#!/bin/bash

# firefox
# http://askubuntu.com/questions/73474/how-to-install-firefox-addon-from-command-line-in-scripts
echo "user_pref(\"browser.startup.homepage\", \"$1\");" >> /home/coderdojo/.mozilla/firefox/*.default/prefs.js

