#!/usr/bin/env bash

frames=`timeout 60s rtl_sdr -f 868.95M -s 1600000 - 2>/dev/null | rtl_wmbus`

IFS_BAK=$IFS
IFS=$'\n'

for frame in $frames; do
    IFS=';'
    read -a strarr <<< "$frame"
    list="${strarr[6]}"$'\n'"${list}"
    IFS=$'\n'
done

sort -u <<< "${list}" | sed '1{/^$/d}'
