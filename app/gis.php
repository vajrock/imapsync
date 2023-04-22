<?php
 //ob_end_flush();
 ini_set("output_buffering", "0");
 ob_implicit_flush(true);
 header('Content-Type: text/event-stream');
 header('Cache-Control: no-cache');

 //вывод в область сообщений
function echoEvent($datatext) {
  echo "data: ".implode("\ndata: ", explode("\n", $datatext))."\n\n";
 }//echoEvent

 echoEvent("Start!");
 //формируем строку запуска скрипта imapsync с параметрами
 $strexe = "/bin/bash /var/www/html/startimapsync.sh "
           .htmlspecialchars($_COOKIE["mail1"]).' '
           .htmlspecialchars($_COOKIE["pass1"])." "
           .htmlspecialchars($_COOKIE["mail2"])." "
           .htmlspecialchars($_COOKIE["pass2"])." "
           .htmlspecialchars($_COOKIE["msrv1"])." "
           .htmlspecialchars($_COOKIE["msrv2"]);
 echoEvent($strexe);
//запускаем sh скрипт из командной строки linux
 $proc = popen($strexe,'r');
//могут быть ограничения php, поэтому достаточно вывести результат окончания миграции
 while (!feof($proc)) {
  echoEvent(fread($proc, 4096));
 }
  echoEvent("Finish!");
?>
