#!/usr/bin/env python3

import json
import os
import sqlite3
import time
from configparser import ConfigParser
from datetime import datetime


def insert_measure_data(database, meter_id, volume):
    insert_query = """INSERT INTO measure
                                  (meter_id,
                                   volume,
                                   timestamp,
                                   hour, 
                                   day, 
                                   month, 
                                   year)
                      VALUES      (?,
                                   ?,
                                   ?,
                                   ?,
                                   ?,
                                   ?,
                                   ?)"""
    timestamp = int(time.time())
    now = datetime.utcfromtimestamp(timestamp)
    conn = sqlite3.connect(database)
    cursor = conn.cursor()

    cursor.execute(
        insert_query,
        (
            meter_id,
            volume,
            timestamp,
            now.strftime("%H"),
            now.strftime("%d"),
            now.strftime("%m"),
            now.strftime("%Y"),
        ),
    )
    conn.commit()
    conn.close()


config_object = ConfigParser()
config_object.read(os.path.join(os.path.dirname(__file__), "config.ini"))
script = config_object["SCRIPT"]["bash_script"]
database = config_object["SQLITE"]["db_filename"]
stream = os.popen(script)
information = stream.read()
information_dict = json.loads(information)
if information_dict["current_volume"]:
    insert_measure_data(
        database, information_dict["meter_id"], information_dict["current_volume"]
    )
