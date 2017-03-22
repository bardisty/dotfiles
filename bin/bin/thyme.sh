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
# |     file | ~/bin/thyme.sh                                                  |
# |     desc | Track application usage with thyme (sourcegraph/thyme)          |
# |   source | https://github.com/bardisty/dotfiles                            |
# |   author | bardisty <b@bah.im>                                             |
# | modified | Wed Mar 22 2017 06:30:35 PDT -0700                              |
# `----------------------------------------------------------------------------'


file_name="$(date +%FT%T%z_%s).json"
output_dir="${HOME}/tmp/thyme"
error_log_dir="${HOME}/var/log/error"
error_log_file="thyme.log"
interval=5

if command -v thyme > /dev/null 2>&1; then
  thyme_bin=$(command -v thyme)
else
  echo "Error: \`thyme\` command not found." >&2
  exit 127
fi

if [ ! -d "$output_dir" ]; then
  if ! mkdir -p "$output_dir"; then
    printf %s\\n "Failed to create output directory: ${output_dir}" >&2
    exit 1
  fi
fi

if [ ! -d "$error_log_dir" ]; then
  if ! mkdir -p "$error_log_dir"; then
    printf %s\\n "Failed to create error log directory: ${error_log_dir}" >&2
  fi
fi


while true; do
  $thyme_bin track -o "${output_dir%/}/${file_name}" \
    2>"${error_log_dir%/}/${error_log_file}"
  sleep "$interval"
done

