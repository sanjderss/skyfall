#!/bin/bash

echo "=========================================="
echo " AUTO INSTALL VERUS MINER UBUNTU (ABEL) "
echo "=========================================="
echo "1. Menyiapkan bumbu-bumbu Ubuntu..."

# Update dan install bahan baku wajib PC/Server
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y libcurl4-openssl-dev libssl-dev libjansson-dev automake autotools-dev build-essential git wget nano

echo "2. Membersihkan sisa file lama (jika ada)..."
cd ~
rm -rf ccminer

echo "3. Mendownload CCminer..."
git clone https://github.com/monkins1010/ccminer.git
cd ccminer

# Catatan: Di PC/Ubuntu, kita tidak perlu mengakali file sse2neon karena 
# arsitektur PC (Intel/AMD) sudah didukung langsung oleh sistem.

echo "4. Merakit mesin Miner (Tunggu sebentar ya bro)..."
chmod +x build.sh configure.sh autogen.sh
./build.sh

echo "=========================================="
echo " INSTALASI BERES! LANGSUNG GASS MINING! "
echo "=========================================="
# Jangan lupa sesuaikan angka -t (Thread) dengan jumlah core CPU Ubuntu kamu!
./ccminer -a verus -o stratum+tcp://ap.luckpool.net:3960 -u RXkkitXME1JCdSLmEQi9avpHoY2udY2tFn.abel -p x -t 4
