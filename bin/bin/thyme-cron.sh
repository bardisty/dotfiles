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
# | modified | Sun Mar 19 2017 10:35:57 PDT -0700                              |
# `----------------------------------------------------------------------------'


data_files="${HOME}/tmp/thyme/?*.json"
save_dir="${HOME}/var/thyme"
interval=300

if [ ! -d "$save_dir" ]; then
  if ! mkdir -p "$save_dir"; then
    printf %s\\n "Failed to create save directory: ${save_dir}"
    exit 1
  fi
fi

while true; do
  if [ -n "$data_files" ]; then
    for file in $data_files; do
      [ -r "$file" ] && cp -f "$file" "$save_dir"
    done
    unset file
  fi
  sleep "$interval"
done

