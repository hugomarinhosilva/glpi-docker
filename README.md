# Deploy com docker-compose

## Deploy sem dados persistentes ( teste )
```yaml
version: "3.8"

services:
  mariadb:
    image: mariadb:10.7
    container_name: mariadb
    hostname: mariadb
    environment:
      - MARIADB_ROOT_PASSWORD=password
      - MARIADB_DATABASE=glpidb
      - MARIADB_USER=glpi_user
      - MARIADB_PASSWORD=glpi

  glpi:
    image: hugomarinhosilva/glpi
    container_name : glpi
    hostname: glpi
    ports:
      - "80:80"
```

## Deploy com release específica

```yaml
version: "3.8"

services:
  mariadb:
    image: mariadb:10.7
    container_name: mariadb
    hostname: mariadb
    environment:
      - MARIADB_ROOT_PASSWORD=password
      - MARIADB_DATABASE=glpidb
      - MARIADB_USER=glpi_user
      - MARIADB_PASSWORD=glpi
      
  glpi:
    image: hugomarinhosilva/glpi
    container_name : glpi
    hostname: glpi
    environment:
      - VERSION_GLPI=9.5.6
    ports:
      - "80:80"
```

## Deploy com dados persistentes

Para implantar com composição docker, você usa docker-com compose.yml e arquivo mariadb.env.
Você pode modificar mariadb.env para personalizar configurações como:

* Senha raiz do MariaDB
* Banco de dados GLPI
* Banco de dados de usuários GLPI
* Senha de usuário GLPI

### mariadb.env
```
MARIADB_ROOT_PASSWORD=senharoot
MARIADB_DATABASE=bancoglpi
MARIADB_USER=usuario_glpi
MARIADB_PASSWORD=glpi123
```

### docker-compose .yml
```yaml
version: "3.2"

services:
  mariadb:
    image: mariadb:10.7
    container_name: mariadb
    hostname: mariadb
    volumes:
      - /var/lib/mysql:/var/lib/mysql
    env_file:
      - ./mariadb.env
    restart: always

  glpi:
    image: hugomarinhosilva/glpi
    container_name : glpi
    hostname: glpi
    ports:
      - "80:80"
    volumes:
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
      - /var/www/html/glpi/:/var/www/html/glpi
    environment:
      - TIMEZONE=America/Araguaina
    restart: always
```

Para implantar, basta executar o seguinte comando no mesmo diretório dos arquivos

```sh
docker-compose up -d
```

# Environnment variables

## TIMEZONE
Se você precisar definir o fuso horário para Apache e PHP

Da linha de comando
```sh
docker run --name glpi --hostname glpi --link mariadb:mariadb --volumes-from glpi-data -p 80:80 --env "TIMEZONE=America/Araguaina" -d hugomarinhosilva/glpi
```

From docker-compose

Modifique essas configurações
```yaml
environment:
     TIMEZONE=America/Araguaina
```
