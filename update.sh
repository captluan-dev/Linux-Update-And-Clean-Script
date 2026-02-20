#!/bin/bash

red='\e[1;31m'
green='\e[1;32m'
yellow='\e[1;33m'
reset='\e[0m'


checar_ambiente() {
    if ! command -v apt &> /dev/null; then
    echo -e "${red}[ERROR] - Esse script é compatível apenas com sistemas baseados em Debian/Ubuntu. Verifique seu sistema operacional e tente novamente.${reset}"
    exit 1
    fi

    if ! ping -c 1 google.com &> /dev/null; then
    echo -e "${red}[ERROR] - Sem conexão com a internet. Verifique sua conexão e tente novamente.${reset}"
    exit 1
    else
    echo -e "${green}[INFO] - Conexão com a internet é válida.${reset}"
    fi

    if ! sudo -v &> /dev/null; then
    echo -e "${red}[ERROR] - Este script requer privilégios de superusuário. Execute o script com 'sudo' e tente novamente.${reset}"
    exit 1
    fi
}

atualizar() {
    echo -e "${yellow}[INFO] - Atualizando o sistema...${reset}"
    if ! (sudo apt update && sudo apt upgrade -y) &> /dev/null; then
        echo -e "${red}[ERROR] - Ocorreu um erro durante a atualização. Verifique os logs para mais detalhes.${reset}"
        exit 1
    fi
}

limpar() {
    echo -e "${yellow}[INFO] - Limpando o sistema...${reset}"
    (sudo apt autoclean && sudo apt autoremove -y) &> /dev/null
}

checar_ambiente
atualizar
limpar

echo -e "${green}[INFO] - Sistema atualizado e limpo com sucesso!${reset}"