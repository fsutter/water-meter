# Water logger

## Prerequisites

### Install system packages
```bash
sudo apt install libtool libusb-1.0-0-dev librtlsdr-dev rtl-sdr build-essential autoconf cmake pkg-config
sudo apt install python3-pip
sudo apt install sqlite3
```

### Install libraries

#### rtl_433
```bash
git clone https://github.com/merbanan/rtl_433.git
cd rtl_433
mkdir build
cd build
cmake ..
make
sudo make install
```

#### rtl-wmbus
```bash
git clone https://github.com/xaelsouth/rtl-wmbus.git
cd rtl-wmbus
make release
sudo make install
```

#### wmbusmeters
```bash
git clone https://github.com/weetmuts/wmbusmeters.git
cd wmbusmeters
./configure
make
sudo make install
```

### Create SQLite database:
```bash
sqlite3 NAME_OF_YOUR_DATABASE_FILE < create_script.sql
```

### Edit config.ini to match your configuration
Set meter_id , meter_name, bash_script and db_filename.

## Installation

### Add a crontab entry
Add an entry in the crontab to call the script every hour: 
```
0 * * * * <path_to_water.py>
```
The crontab can be configured with:
```bash
crontab -e
```
