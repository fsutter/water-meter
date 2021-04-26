#!/usr/bin/env bash

rtl_sdr -f 868.95M -s 1600000 - 2>/dev/null | rtl_wmbus | wmbusmeters --t1 stdin:rtlwmbus
