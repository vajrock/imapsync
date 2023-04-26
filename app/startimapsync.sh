#!/bin/bash
#переход в каталог откуда был запущен данный скрипт
#cd `dirname $0`
#запуск imapsync с нужными параметрами
/var/www/html/imapsync \
  --host1 $5:993    --user1 $1 --password1 $2 \
  --host2 $6:143    --user2 $3 --password2 $4 \
  --ssl1 \
  --automap \
  --folderfirst INBOX \
  --regextrans2 "s/&BB4EQgQ,BEAEMAQyBDsENQQ9BD0ESwQ1-/Sent/" \
  --regextrans2 "s/&BBoEPgRABDcEOAQ9BDA-/Trash/" \
  --regextrans2 "s/&BCEEPwQwBDw-/Junk/" \
  --regextrans2 "s/&BCcENQRABD0EPgQyBDgEOgQ4-/Drafts/" \
  --regexflag 's/\\Unseen//g' \
  --useheader Message-Id
