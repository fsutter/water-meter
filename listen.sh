#!/usr/bin/env bash

if [ "$#" -ne 2 ]
then
    METER_ID="$(python3 -c 'from configparser import ConfigParser; import os; config_object = ConfigParser(); config_object.read("'`dirname "$(readlink -f "$0")"`'/config.ini"); print(config_object["METER"]["meter_id"])')"
    METER_NAME="$(python3 -c 'from configparser import ConfigParser; import os; config_object = ConfigParser(); config_object.read("'`dirname "$(readlink -f "$0")"`'/config.ini"); print(config_object["METER"]["meter_name"])')"
else
    METER_ID=$1
    METER_NAME=$2
fi

rtl_sdr -f 868.95M -s 1600000 - 2>/dev/null | rtl_wmbus | wmbusmeters --t1 stdin:rtlwmbus ${METER_NAME} izar ${METER_ID,,} NOKEY
