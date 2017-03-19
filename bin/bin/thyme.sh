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
# | modified | Sun Mar 19 2017 10:25:59 PDT -0700                              |
# `----------------------------------------------------------------------------'


FILE_NAME="$(date +%FT%T%z_%s).json"
OUTPUT_DIR="${HOME}/tmp/thyme"
ERROR_LOG_DIR="${HOME}/var/log/error"
ERROR_LOG_FILE="thyme.log"
INTERVAL=5

if command -v thyme > /dev/null 2>&1; then
  THYME_BIN=$(command -v thyme)
else
  echo "Error: \`thyme\` command not found." >&2
  exit 127
fi

[ ! -d "$OUTPUT_DIR" ] && mkdir -p "$OUTPUT_DIR"
[ ! -d "$ERROR_LOG_DIR" ] && mkdir -p "$ERROR_LOG_DIR"

while true; do
  $THYME_BIN track -o "${OUTPUT_DIR}/${FILE_NAME}" \
    2>"${ERROR_LOG_DIR}/${ERROR_LOG_FILE}"
  sleep "$INTERVAL"
done

