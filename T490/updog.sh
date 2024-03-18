#!/bin/bash
grim -g "$(slurp -d)" /tmp/updog.png
[[ $* == *edit* ]] && drawing /tmp/updog.png
curl -X POST -F 'file=@/tmp/updog.png' -F 'woof=REDACTED-FOR-GIT' https://garbage.dog/updog.php | wl-copy
rm /tmp/updog.png
