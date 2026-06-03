#!/bin/bash

echo "=========================================="
echo " AUTO INSTALL VERUS MINER KHUSUS ABEL "
echo "=========================================="
echo "1. Menyiapkan bumbu-bumbu Termux..."

DEBIAN_FRONTEND=noninteractive pkg update -y < /dev/null
DEBIAN_FRONTEND=noninteractive pkg upgrade -y -o Dpkg::Options::="--force-confold" < /dev/null
DEBIAN_FRONTEND=noninteractive pkg install git make clang autoconf automake libtool wget nano -y < /dev/null

echo "2. Membersihkan sisa file lama (jika ada)..."
cd ~
rm -rf ccminer

echo "3. Mendownload CCminer..."
git clone https://github.com/monkins1010/ccminer.git
cd ccminer

echo "4. Mendownload file sse2neon yang sering hilang..."
mkdir -p sse2neon
wget https://raw.githubusercontent.com/DLTcollab/sse2neon/master/sse2neon.h -O sse2neon/sse2neon.h

echo "5. Merakit mesin Miner (Tunggu sebentar ya bro)..."
chmod +x build.sh configure.sh autogen.sh
./build.sh

echo "6. Memasang dompet RXkkitXME1JCdSLmEQi9avpHoY2udY2tFn.abel..."
cat << 'EOF' > config.json
{
    "pools": [{
        "name": "Luckpool",
        "url": "stratum+tcp://ap.luckpool.net:3960",
        "timeout": 150,
        "caller": "web"
    }],
    "user": "RXkkitXME1JCdSLmEQi9avpHoY2udY2tFn.abel",
    "pass": "x",
    "algo": "verus",
    "threads": 5,
    "cpu-priority": 1,
    "retry-pause": 5,
    "api-allow": "127.0.0.1",
    "api-bind": "0.0.0.0:4068"
}
EOF

echo "=========================================="
echo " INSTALASI BERES! LANGSUNG GASS MINING! "
echo "=========================================="
./ccminer -c config.json
