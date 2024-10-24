#!/bin/bash

green='\033[0;32m'
nc='\033[0m' 

echo -e "${green}Оновлюємо та встановлюємо необхідні пакети...${nc}"
sudo apt update && sudo apt upgrade -y

echo -e "${green}Встановлення Git, Unzip, Nano...${nc}"
sudo apt-get install git -y
sudo apt install unzip -y
sudo apt install nano -y

echo -e "${green}Встановлення Python...${nc}"
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt update
sudo apt install python3.11 -y
echo -e "${green}Перевіряємо версію Python...${nc}"
python3.11 --version

echo -e "${green}Встановлення Poetry...${nc}"
sudo apt install python3-pip python3-venv curl -y
curl -sSL https://install.python-poetry.org | python3 -
export PATH="$HOME/.local/bin:$PATH"
source ~/.bashrc
echo -e "${green}Перевіряємо Poetry...${nc}"
poetry --version

echo -e "${green}Встановлення Node.js та npm...${nc}"
curl -fsSL https://fnm.vercel.app/install | bash
source ~/.bashrc
fnm use --install-if-missing 22
echo -e "${green}Перевіряємо Node.js і npm...${nc}"
node -v && npm -v

echo -e "${green}Встановлення залежності...${nc}"
sudo apt-get install nodejs -y
npm install -g yarn
echo -e "${green}Перевіряємо  Yarn...${nc}"
yarn --version

echo -e "${green}Клонуємо репозиторій і заходимо до нього...${nc}"
git clone https://github.com/vana-com/vana-dlp-chatgpt.git
cd vana-dlp-chatgpt

cp .env.example .env

echo -e "${green}Встановити залежності...${nc}"
poetry install

echo -e "${green}Встановити CLI...${nc}"
pip install vana

echo -e "${green}Створюємо гаманець! Збережіть дані...${nc}"
vanacli wallet create --wallet.name default --wallet.hotkey default

read -p "$(echo -e "${green}Ви зберегли дані? (y/n): ${nc}") " confirm_wallet
if [[ "$confirm_wallet" != "y" ]]; then
    echo -e "${green}Скрипт завершено. Будь ласка, збережіть дані і запустіть скрипт ще раз.${nc}"
    exit 1
fi

echo -e "${green}Експортуємо приватний ключ для Coldkey...${nc}"
vanacli wallet export_private_key

echo -e "${green}Експортуємо приватний ключ для Hotkey...${nc}"
vanacli wallet export_private_key

read -p "$(echo -e "${green}Ви зберегли приватні ключі? (y/n): ${nc}") " confirm_keys
if [[ "$confirm_keys" != "y" ]]; then
    echo -e "${green}Скрипт завершено. Будь ласка, збережіть ключі і запустіть скрипт ще раз.${nc}"
    exit 1
fi

echo -e "${green}Генерація ключів...${nc}"
./keygen.sh
