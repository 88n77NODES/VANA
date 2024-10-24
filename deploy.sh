#!/bin/bash

green='\033[0;32m'
nc='\033[0m' 

echo -e "${GREEN}====================================================${RESET}"
echo -e "${green}Деплой Moksha...${nc}"
echo -e "${green}Зупиняємо ноду...${nc}"
sudo systemctl stop vana.service
apt install npm

echo -e "${green}Видаляємо папку і завантажуємо нову та переходимо до неї...${nc}"
cd $HOME
rm -rf vana-dlp-smart-contracts
git clone https://github.com/Josephtran102/vana-dlp-smart-contracts
cd vana-dlp-smart-contracts

echo -e "${green}Встановлюємо yarn та перевіряємо його версію...${nc}"
npm install -g yarn
yarn --version

echo -e "${green}Встановлюємо залежності...${nc}"
yarn install

echo -e "${green}Створюємо файл .env та редагуємо його...${nc}"
cp .env.example .env
nano .env

echo -e "${green}Перевірте наявність тестових токенів...${nc}"

echo -e "${GREEN}====================================================${RESET}"
echo -e "${green}Робимо деплой...${nc}"
npx hardhat deploy --network moksha --tags DLPDeploy
