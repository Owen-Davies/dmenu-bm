#!/usr/bin/env bash

declare -A g bmarray;

while IFS=\| read -r guid date id url title tags;
do
  bookmark="$title "-" "$url" "-" "$tags"";
  bmarray["$bookmark"]="$url";
done < /home/owen/Nextcloud/bookmarks/bm.lnk

function load() {
  while IFS=\| read -r guid date id url title tags;
  do
    bookmark="$title "-" "$url" "-" "$tags"";
    printf "$bookmark\n";
  done < /home/owen/Nextcloud/bookmarks/bm.lnk
  printf
}

choice=$(load | dmenu -i -l 15 -p "Add/Open bookmark:")

case "$choice" in
  Add) dmenu-bm-add.sh ;;
  *) bm -o ${bmarray[$choice]} ;;
esac
