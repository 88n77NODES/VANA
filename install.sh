#!/bin/bash

green='\033[0;32m'
nc='\033[0m'

wget https://raw.githubusercontent.com/88n77/Logo-88n77/main/logo.sh
chmod +x logo.sh
./logo.sh

setup_url=". <(wget -qO - https://raw.githubusercontent.com/88n77NODES/VANA/main/setup.sh)" 
update_url=". <(wget -qO - https://raw.githubusercontent.com/88n77NODES/VANA/main/update.sh)" 
delete_url=". <(wget -qO - https://raw.githubusercontent.com/88n77NODES/VANA/main/delete.sh)" 
deploy_dlp_url=". <(wget -qO - https://raw.githubusercontent.com/88n77NODES/VANA/main/deploy.sh)" 
validator_setup_url=". <(wget -qO - https://raw.githubusercontent.com/88n77NODES/VANA/main/validator.sh)" 

menu_options=("Встановити" "Оновити" "Видалити" "Деплой смарт-контракту DLP" "Встановлення валідатора" "Вийти")
PS3='Оберіть дію: '

select choice in "${menu_options[@]}"
do
    case $choice in
        "Встановити")
            echo -e "${green}Встановлення...${nc}"
            bash <(curl -s $setup_url)
            ;;
        "Оновити")
            echo -e "${green}Оновлення...${nc}"
            bash <(curl -s $update_url)
            ;;
        "Видалити")
            echo -e "${green}Видалення...${nc}"
            bash <(curl -s $delete_url)
            ;;
        "Деплой смарт-контракту DLP")
            echo -e "${green}Деплой смарт-контракту DLP...${nc}"
            bash <(curl -s $deploy_dlp_url)
            ;;
        "Встановлення валідатора")
            echo -e "${green}Встановлення валідатора...${nc}"
            bash <(curl -s $validator_setup_url)
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
