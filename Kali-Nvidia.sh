#!/bin/bash

# Update and install necessary tools
apt update
apt install -y wget gpg

# Add Kali repository to sources list
echo "deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware" > /etc/apt/sources.list
echo "deb-src http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware" >> /etc/apt/sources.list

# Update package list after adding Kali repositories
apt update

# Download and install Kali archive keyring
wget https://http.kali.org/kali/pool/main/k/kali-archive-keyring/kali-archive-keyring/kali-archive-keyring_2024.1_all.deb
if [ $? -ne 0 ]; then
    echo "Failed to download Kali archive keyring."
    exit 1
fi
apt install ./kali-archive-keyring_2024.1_all.deb
if [ $? -ne 0 ]; then
    echo "Failed to install Kali archive keyring."
    exit 1
fi

# Update package list again after installing keyring
apt update

# Install Linux headers for kernel version
apt install -y linux-headers-amd64
if [ $? -ne 0 ]; then
    echo "Failed to install linux-headers."
    exit 1
fi

# Install NVIDIA driver and CUDA toolkit
apt install -y nvidia-driver nvidia-cuda-toolkit
if [ $? -ne 0 ]; then
    echo "Failed to install NVIDIA drivers and CUDA toolkit."
    exit 1
fi

# Reboot the system
echo "Rebooting the system to complete the setup..."
reboot
