#!/bin/bash

green='\033[0;32m'
nc='\033[0m' 

echo -e "${GREEN}====================================================${RESET}"
echo -e "${green}Встановлення валідатора...${nc}"

echo -e "${green}Витягуємо публічний ключ...${nc}"
cat /root/vana-dlp-chatgpt/public_key_base64.asc

read -p "$(echo -e "${green}Ви зберегли ключ? (y/n): ${nc}")" key_saved
if [[ "$key_saved" != "y" ]]; then
    echo -e "${green}Будь ласка, збережіть ключ і спробуйте ще раз.${nc}"
    exit 1
fi

echo -e "${green}Переходимо до папки vana-dlp-chatgpt...${nc}"
cd /root/vana-dlp-chatgpt

echo -e "${green}Редагуємо .env...${nc}"
nano .env

read -p "$(echo -e "${green}Ви виконали дії в гамаці? (y/n): ${nc}")" actions_done
if [[ "$actions_done" != "y" ]]; then
    echo -e "${green}Будь ласка, виконайте дії в гамаці і спробуйте ще раз.${nc}"
    exit 1
fi

echo -e "${green}Реєструємо нашого валідатора...${nc}"
./vanacli dlp register_validator --stake_amount 10

read -p "$(echo -e "${green}Введіть адресу вашого гаманця Hotkey: ${nc}")" wallet_address
./vanacli dlp approve_validator --validator_address="$wallet_address"

echo -e "${green}Запускаємо валідатора...${nc}"
poetry run python -m chatgpt.nodes.validator

echo -e "${green}Тепер натискає Ctrl+C, щоб зупинити валідатора...${nc}"

echo -e "${green}Створюємо сервісний файл...${nc}"
echo $(which poetry)
sudo tee /etc/systemd/system/vana.service << EOF

[Unit]
Description=Vana Validator Service
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/root/vana-dlp-chatgpt
ExecStart=/root/.local/bin/poetry run python -m chatgpt.nodes.validator
Restart=on-failure
RestartSec=10
Environment=PATH=/root/.local/bin:/usr/local/bin:/usr/bin:/bin:/root/vana-dlp-chatgpt/myenv/bin
Environment=PYTHONPATH=/root/vana-dlp-chatgpt

[Install]
WantedBy=multi-user.target
EOF

echo -e "${green}Запускаємо сервіс...${nc}"
sudo systemctl daemon-reload && \
sudo systemctl enable vana.service && \
sudo systemctl start vana.service && \
sudo systemctl status vana.service

echo -e "${green}Перевіряємо логи...${nc}"
sudo journalctl -u vana.service -f
