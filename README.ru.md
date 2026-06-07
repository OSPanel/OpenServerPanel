[![en](https://img.shields.io/badge/lang-en-green.svg)](https://github.com/OSPanel/OpenServerPanel)

# Open Server Panel

**Полноценная портативная dev-машина на стероидах для Windows**

Open Server Panel — это мощный WAMP-стек, который заменяет десяток инструментов и экономит часы настройки каждый день.

Превосходный выбор для тех, кто начинает свой путь в веб-разработке, и для профессионалов, которым не нужна привязка к Linux-окружению.

## ✨ Основной стек
**Apache** (+12 модулей) + **Caddy** (+142 модуля) + **Nginx** (+19 модулей) • **MySQL** • **MariaDB** • **MongoDB** (MongoShell + MongoTools) • **PHP** (+115 расширений) • **PostgreSQL**

## 📦 Что ещё внутри
- **Брокеры сообщений**: RabbitMQ (+ ErlangOTP)
- **Кэширование**: Redis + Memcached
- **DNS-серверы**: Bind + Unbound
- **Тестирование почты**: Mailpit + SMTP4dev
- **Обработка медиа**: FFMpeg + ImageMagick + Ghostscript + Libwebp
- **Runtime-окружения**: Node.js (NVM) + Go
- **Backend как сервис**: PocketBase
- **Файловые серверы**: SFTPGo (SFTP/FTP/WebDAV)
- **Секреты и безопасность**: Vault + age-шифрование

## >_ Консольный арсенал
Свежие инструменты (**age**, **bat**, **dust**, **fd**, **lego**, **oha**, **opa**, **sd**, **xh**) + проверенная классика (**7za**, **aria2c**, **brotli**, **composer**, **curl**, **geoiplookup**, **jq**, **mmdbinspect**, **sass**, **sqlite3**, **wget**)

## Почему это монстр?
✅ Все версии PHP/MySQL/Node параллельно  
✅ Сетевой стек настроен из коробки  
✅ Автоматические TLS-сертификаты (локальные + Let's Encrypt)  
✅ Нативная производительность без виртуализации  
✅ Нет схожих аналогов среди других решений для Windows

**Коротко**: All-in-one решение для полноценной fullstack-разработки любой сложности.

**Документация:** [https://github.com/OSPanel/OpenServerPanel/wiki/Документация](https://github.com/OSPanel/OpenServerPanel/wiki/%D0%94%D0%BE%D0%BA%D1%83%D0%BC%D0%B5%D0%BD%D1%82%D0%B0%D1%86%D0%B8%D1%8F)

**Загрузка:** https://ospanel.io/download/

## Системные требования

| Компонент | Требования |
|---|---|
| Операционная система | Windows 10 / Windows Server 2016 или новее |
| Свободные аппаратные ресурсы | Минимум 4 ГБ RAM и 15 ГБ SSD |
| Обязательное ПО | MSVC++ Redistributable Packages (включено в комплект поставки) |
| Файловая система | NTFS (сетевые диски не поддерживаются) |

> [!CAUTION]
> **Не поддерживаются** Linux, macOS, Windows XP, Windows 7, Windows 8, 32-битные системы, процессоры без SSE4.2.

## Графический интерфейс

![Open Server Panel GUI](./resources/screenshots/gui.png)

## Интерфейс командной строки

![Open Server Panel Console](./resources/screenshots/cli.png)
