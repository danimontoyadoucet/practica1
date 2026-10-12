
#!/bin/bash

# Mostrar comandos y detenerse si ocurre un error
set -ex

# Cargamos las variables de configuración
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

set -a
source "$SCRIPT_DIR/.env"
set +a

# Actualizar lista de paquetes
apt update

# Instalar GoAccess
apt install goaccess -y

# Instalamos los paquetes necesarios para phpMyAdmin
apt install php-mbstring php-zip php-gd php-curl php-xml -y

# Instalamos phpMyAdmin
DEBIAN_FRONTEND=noninteractive apt install phpmyadmin -

# Instalamos Adminer
apt install adminer -y

# Habilitamos phpMyAdmin en Apache
if [ ! -e /etc/apache2/conf-available/phpmyadmin.conf ]; then
    ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
fi

a2enconf phpmyadmin

# Habilitamos Adminer en Apache
a2enconf adminer

# Comprobamos la configuración de Apache
apache2ctl configtest

# Recargamos Apache
systemctl reload apache2