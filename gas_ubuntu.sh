#!/bin/bash

echo "=========================================="
echo " AUTO INSTALL VERUS MINER UBUNTU (ABEL) "
echo "=========================================="
echo "1. Menyiapkan bumbu-bumbu Ubuntu..."

# Menambahkan 'cpulimit' ke dalam daftar instalasi dan menutup prompt (</dev/null)
sudo apt-get update -y < /dev/null
sudo apt-get upgrade -y < /dev/null
sudo apt-get install -y libcurl4-openssl-dev libssl-dev libjansson-dev automake autotools-dev build-essential git wget nano cpulimit < /dev/null

echo "2. Membersihkan sisa file lama (jika ada)..."
cd ~
rm -rf ccminer

echo "3. Mendownload CCminer..."
git clone https://github.com/monkins1010/ccminer.git
cd ccminer

echo "4. Merakit mesin Miner (Tunggu sebentar ya bro)..."
chmod +x build.sh configure.sh autogen.sh
./build.sh

echo "5. Menghitung Batasan CPU (Max 60%)..."
# Di Linux, 1 core dihitung 100%. Jika PC punya 4 core = 400%.
# Script ini akan otomatis menghitung 60% dari total kapasitas PC kamu.
TOTAL_CORES=$(nproc)
LIMIT_PERSEN=$((TOTAL_CORES * 60))

echo ">> PC ini memiliki $TOTAL_CORES Core."
echo ">> Mengunci CPU Miner di limit angka: $LIMIT_PERSEN (Setara 60% beban maksimal)."

echo "=========================================="
echo " INSTALASI BERES! LANGSUNG GASS MINING! "
echo "=========================================="
# cpulimit akan merantai ccminer agar tidak melebihi batas 60%, dan -t 2 memaksa pakai 2 thread
cpulimit -l $LIMIT_PERSEN -- ./ccminer -a verus -o stratum+tcp://ap.luckpool.net:3960 -u RXkkitXME1JCdSLmEQi9avpHoY2udY2tFn.abel -p x -t 2
