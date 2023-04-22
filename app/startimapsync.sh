#!/bin/bash
#переход в каталог откуда был запущен данный скрипт
cd `dirname $0`
#запуск imapsync с нужными параметрами
 /home/user/imapsync/./imapsync \
#сервер начального почтового ящика, логин, пароль
  --host1 $5:993    --user1 $1 --password1 $2 \
#сервер конечного почтового ящика, логин, пароль
  --host2 $6:993    --user2 $3 --password2 $4 \
#использование  шифрования при подключении к серверу
  --ssl1  --ssl2 \
#сопоставление папок
  --automap \
#первой синхронизируем папку входящих
  --folderfirst INBOX \
#сопоставление папок
  --regextrans2 "s/&BB4EQgQ,BEAEMAQyBDsENQQ9BD0ESwQ1-/Sent/" \
  --regextrans2 "s/&BBoEPgRABDcEOAQ9BDA-/Trash/" \
  --regextrans2 "s/&BCEEPwQwBDw-/Junk/" \
  --regextrans2 "s/&BCcENQRABD0EPgQyBDgEOgQ4-/Drafts/" \
#правильно принимаем не прочитанные письма во Входящих
  --regexflag 's/\\Unseen//g' \
#Сравнение полученных и отправленных писем по параметру Идентификационный номер
  --useheader Message-Id
  