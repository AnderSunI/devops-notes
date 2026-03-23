# Шпаргалка по Docker (боевая, проверенная)

## 📦 Основные понятия

| Понятие | Что это |
|---------|---------|
| Образ (image) | Шаблон, из которого создаются контейнеры. Неизменяемый слой. |
| Контейнер (container) | Запущенный экземпляр образа. Имеет свои процессы, сеть, файловую систему. |
| Dockerfile | Файл с инструкциями для сборки образа. |
| docker-compose.yml | Описание группы контейнеров, которые работают вместе. |
| Volume | Папка, которая живёт вне контейнера и может переживать его пересоздание. |
| Сеть (network) | Виртуальная сеть, через которую контейнеры общаются между собой. |

## 🔧 Основные команды

| Команда | Что делает | Пример |
|---------|------------|--------|
| `docker ps` | Показать запущенные контейнеры | `docker ps -a` — все, включая остановленные |
| `docker images` | Показать образы | |
| `docker build -t имя .` | Собрать образ из Dockerfile в текущей папке | |
| `docker run -d -p 8000:8000 имя` | Запустить контейнер из образа | |
| `docker exec -it <id> bash` | Зайти внутрь работающего контейнера | |
| `docker logs <id>` | Показать логи контейнера | |
| `docker stop <id>` / `docker rm <id>` | Остановить / удалить контейнер | |
| `docker rmi <id>` | Удалить образ | |
| `docker system prune -a` | Удалить все остановленные контейнеры, неиспользуемые образы, сети | |

## 🐳 Docker Compose

| Команда | Что делает |
|---------|------------|
| `docker-compose up -d` | Запустить все сервисы из `docker-compose.yml` в фоне |
| `docker-compose down` | Остановить и удалить контейнеры, сети (но не тома) |
| `docker-compose down -v` | Удалить и тома (осторожно — сотрёт данные!) |
| `docker-compose build --no-cache` | Пересобрать образы без использования кэша |
| `docker-compose logs <сервис>` | Логи конкретного сервиса |
| `docker-compose ps` | Статус контейнеров |

## 💡 Типичные проблемы и их решение

| Проблема | Причина | Решение |
|----------|---------|---------|
| `Bind for 0.0.0.0:8000 failed: port is already allocated` | Порт 8000 уже занят другим процессом (или старым контейнером) | Найти процесс: `sudo ss -tulpn \| grep :8000`. Остановить контейнер или убить процесс. |
| `ERROR: No such service: api` | В `docker-compose.yml` нет сервиса с таким именем | Проверить имена сервисов в файле. |
| `KeyError: 'ContainerConfig'` | Старая версия docker-compose, глюк при пересоздании контейнера | `docker-compose down` и `docker-compose up -d` заново, или удалить старые контейнеры вручную. |
| `ModuleNotFoundError: No module named 'sqlalchemy'` | Зависимости не установились в контейнере | Проверить `requirements.txt`, пересобрать с `--no-cache`. |
| Контейнер сразу падает (`Exit 1`) | Ошибка внутри приложения | Смотреть логи: `docker-compose logs <сервис>` |

## 📂 Полезные файлы

### `.dockerignore`
Аналог `.gitignore` для Docker. Указывает, какие файлы не копировать в образ.

### `Dockerfile` (минимальный пример)
```dockerfile
FROM python:3.10-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["python", "app.py"]

version: '3.8'
services:
  app:
    build: .
    ports:
      - "8000:8000"
    volumes:
      - ./app:/app
    depends_on:
      - db
  db:
    image: postgres:15
    environment:
      POSTGRES_PASSWORD: secret
    volumes:
      - pgdata:/var/lib/postgresql/data
volumes:
  pgdata:
