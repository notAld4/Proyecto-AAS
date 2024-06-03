#!/usr/bin/env bash

which docker &> /dev/null && which docker-compose &> /dev/null || { 
    echo "Necesitas docker y docker-compose"
    exit 1
}

if docker network ls | grep -q "dns-net"; then
    echo "La red dns-net ya existe, omitiendo"
else
    echo "Creando red: dns-net (10.10.10.0/24)" && docker network create --subnet=10.10.10.0/24 --gateway=10.10.10.1 dns-net
fi

if docker network ls | grep -q "wan-net"; then
    echo "La red dns-net ya existe, omitiendo"
else
    echo "Creando red: wan-net (bridge)" && docker network create --driver bridge wan-net
fi

if docker volume ls | grep -q "base-datos-vol"; then
	echo "El volumen para la base de datos ya existe, omitiendo"
else
	echo "Crendo volumen base-datos-vol" && docker volume create base-datos-vol
fi

if docker volume ls | grep -q "raid-vol"; then
	echo "El volumen para la base de datos ya existe, omitiendo"
else
	echo "Crendo volumen raid-vol" && docker volume create raid-vol
fi

docker-compose -f /home/c4rta/Documentos/Docker/docker-compose.yml up -d
