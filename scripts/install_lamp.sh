#!/bin/bash
# e: Finaliza si hay errores
# x: Muestra los comandos que se están ejecutando
set -ex

# Actualizamos los repositorios
apt update

# Instalamos el servidor web apache
apt install apache2 -y