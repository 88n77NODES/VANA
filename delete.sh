#!/bin/bash

green='\033[0;32m'
nc='\033[0m'

echo -e "${green}Видалення валідатора з сервера...${nc}"

# Зупиняємо та видаляємо сервіс валідатора
echo -e "${green}Зупиняємо сервіс валідатора...${nc}"
sudo systemctl stop vana.service

echo -e "${green}Видаляємо сервіс валідатора...${nc}"
sudo systemctl disable vana.service
sudo rm /etc/systemd/system/vana.service

# Очищуємо кеш системних демонів
echo -e "${green}Очищуємо кеш системних демонів...${nc}"
sudo systemctl daemon-reload

# Видаляємо папку з валідатором
echo -e "${green}Видаляємо файли валідатора...${nc}"
sudo rm -rf /root/vana-dlp-chatgpt

# Видаляємо Python середовище та залежності
echo -e "${green}Видаляємо Python середовище та Poetry...${nc}"
sudo rm -rf /root/.local/share/pypoetry /root/.cache/pypoetry

# Опціонально: видаляємо залишки логів та інших тимчасових файлів
echo -e "${green}Очищуємо логи валідатора...${nc}"
sudo journalctl --vacuum-time=1s

echo -e "${green}Валідатор повністю видалено з сервера.${nc}"
