#!/bin/bash

green='\033[0;32m'
nc='\033[0m'

wget https://raw.githubusercontent.com/88n77/Logo-88n77/main/logo.sh
chmod +x logo.sh
./logo.sh

setup_url="https://raw.githubusercontent.com/88n77NODES/VANA/main/setup.sh" 
update_url="https://raw.githubusercontent.com/88n77NODES/VANA/main/update.sh" 
delete_url="https://raw.githubusercontent.com/88n77NODES/VANA/main/delete.sh" 
deploy_dlp_url="https://raw.githubusercontent.com/88n77NODES/VANA/main/deploy.sh" 
validator_setup_url="https://raw.githubusercontent.com/88n77NODES/VANA/main/validator.sh" 

menu_options=("Встановити" "Оновити" "Видалити" "Деплой смарт-контракту DLP" "Встановлення валідатора" "Вийти")
PS3='Оберіть дію: '

select choice in "${menu_options[@]}"
do
    case $choice in
        "Встановити")
            echo -e "${green}Встановлення...${nc}"
            echo "Виконується: bash <(curl -s $setup_url)"
            bash <(curl -s $setup_url) || { echo "Помилка під час встановлення."; exit 1; }
            ;;
        "Оновити")
            echo -e "${green}Оновлення...${nc}"
            echo "Виконується: bash <(curl -s $update_url)"
            bash <(curl -s $update_url) || { echo "Помилка під час оновлення."; exit 1; }
            ;;
        "Видалити")
            echo -e "${green}Видалення...${nc}"
            echo "Виконується: bash <(curl -s $delete_url)"
            bash <(curl -s $delete_url) || { echo "Помилка під час видалення."; exit 1; }
            ;;
        "Деплой смарт-контракту DLP")
            echo -e "${green}Деплой смарт-контракту DLP...${nc}"
            echo "Виконується: bash <(curl -s $deploy_dlp_url)"
            bash <(curl -s $deploy_dlp_url) || { echo "Помилка під час деплою."; exit 1; }
            ;;
        "Встановлення валідатора")
            echo -e "${green}Встановлення валідатора...${nc}"
            echo "Виконується: bash <(curl -s $validator_setup_url)"
            bash <(curl -s $validator_setup_url) || { echo "Помилка під час встановлення валідатора."; exit 1; }
            ;;
        "Вийти")
            echo -e "${green}Вихід...${nc}"
            break
            ;;
        *)
            echo "Невірний вибір!"
            ;;
    esac
done
