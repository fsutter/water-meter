#!/usr/bin/env bash

METER_ID="$(python3 -c 'from configparser import ConfigParser; import os; config_object = ConfigParser(); config_object.read("'`dirname "$(readlink -f "$0")"`'/config.ini"); print(config_object["METER"]["meter_id"])')"
METER_NAME="$(python3 -c 'from configparser import ConfigParser; import os; config_object = ConfigParser(); config_object.read("'`dirname "$(readlink -f "$0")"`'/config.ini"); print(config_object["METER"]["meter_name"])')"

frames=`timeout 20s rtl_sdr -f 868.95M -s 1600000 - 2>/dev/null | rtl_wmbus | grep ${METER_ID}`
decoded=`echo "${frames##*$'\n'}" | wmbusmeters --silent --t1 stdin:rtlwmbus ${METER_NAME} izar ${METER_ID,,}  NOKEY`

#Read the split words into an array based on IFS delimiter
read -a strarr <<< "$decoded"

printf '{"meter_id":"%s","meter_name":"%s","current_volume":"%s"' ${strarr[1]} ${strarr[0]} ${strarr[4]}
printf ',"current_date":"%s","current_time":"%s"' ${strarr[16]} ${strarr[17]}
printf ',"historical_volume":"%s","historical_date":"%s"' ${strarr[6]} ${strarr[8]}
printf ',"remaining_battery_life":"%s","remaining_battery_life_unit":"%s"}\n' ${strarr[9]} ${strarr[10]}
