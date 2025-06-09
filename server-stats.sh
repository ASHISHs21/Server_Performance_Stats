#!/bin/bash

echo "======================================="
echo "📊 SERVER PERFORMANCE STATS"
echo "======================================="

# OS and kernel info
echo -e "\n🖥️ OS Version:"
cat /etc/os-release | grep -E '^PRETTY_NAME' | cut -d= -f2 | tr -d \"

echo -e "\n🔧 Kernel Version:"
uname -r

# Uptime and load average
echo -e "\n⏱️ Uptime and Load Average:"
uptime -p
echo "Load Average: $(uptime | awk -F'load average: ' '{print $2}')"

# Logged in users
echo -e "\n👥 Logged-in Users:"
who | wc -l

# Failed login attempts
echo -e "\n❌ Failed Login Attempts:"
journalctl _SYSTEMD_UNIT=sshd.service | grep "Failed password" | wc -l

# CPU usage
echo -e "\n💻 Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "Used: " $2 + $4 "%, Idle: " $8 "%"}'

# Memory usage
echo -e "\n🧠 Total Memory Usage:"
free -h | awk '/Mem:/ {printf "Used: %s, Free: %s (%.2f%% used)\n", $3, $4, $3*100/($3+$4)}'

# Disk usage
echo -e "\n💾 Total Disk Usage:"
df -h --total | grep total | awk '{printf "Used: %s, Free: %s (%.2f%% used)\n", $3, $4, $5}'

# Top 5 processes by CPU usage
echo -e "\n🔥 Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# Top 5 processes by Memory usage
echo -e "\n📈 Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

echo -e "\n✅ Analysis complete."
echo "======================================="
