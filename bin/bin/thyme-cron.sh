#!/usr/bin/env sh
#
#                    dP   dP
#                    88   88
#                  d8888P 88d888b. dP    dP 88d8b.d8b. .d8888b.
#                    88   88'  `88 88    88 88'`88'`88 88ooood8
#                    88   88    88 88.  .88 88  88  88 88.  ...
# .----------------- dP   dP    dP `8888P88 dP  dP  dP `88888P' ---------------.
# |::::::::::::::::::..:::..::::..:......88 ..::..::..::......:::::::::::::::::|
# |:::::::::::::::::::::::::::::::::d8888P ::::::::::::::::::::::::::::::::::::|
# |:::::::::::::::::::::::::::::::::......:::::::::::::::::::::::::::::::::::::|
# |----------------------------------------------------------------------------|
# |     file | ~/bin/thyme-cron.sh                                             |
# |     desc | Periodically copy thyme data files from memory to disk          |
# |   source | https://github.com/bardisty/dotfiles                            |
# |   author | bardisty <b@bah.im>                                             |
# | modified | Mon Dec 19 2016 12:29:24 PST -0800                              |
# `----------------------------------------------------------------------------'


DATA_FILES="${HOME}/tmp/thyme/?*.json"
SAVE_DIR="${HOME}/var/thyme"
INTERVAL=600

[ ! -d "$SAVE_DIR" ] && mkdir -p "$SAVE_DIR"

while true; do
  if [ -n "$DATA_FILES" ]; then
    for file in $DATA_FILES; do
      [ -r "$file" ] && cp -f "$file" "$SAVE_DIR"
    done
    unset file
  fi
  sleep "$INTERVAL"
done

