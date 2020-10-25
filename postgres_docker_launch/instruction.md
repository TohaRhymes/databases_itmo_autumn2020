
## Инструкция по запуску postgreSQL локально, используя docker


__Установка__

Прописываем в командной строке:

```
sudo apt install docker
sudo apt install docker-compose
sudo apt install docker.io
```

__Конфигурация__

Создаем docker-compose.yml:

```
PostgreSQL:
    image: sameersbn/postgresql:10-2
    ports:
        - "5432:5432"
    environment:
        - DB_USER=user
        - DB_PASS=user
        - DB_NAME=dbname
    volumes:
        - /srv/docker/postgresql:/var/lib/postgresql
```

__Запуск__

Прописываем в командной строке:

```
sudo systemctl start docker
sudo docker-compose up
```
