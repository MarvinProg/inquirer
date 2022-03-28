# inquirer
___
Это приложение, неофициальный клон сайта ask.fm.
В нем есть авторизация, с помощью контроллеров (без использование гема device), смена пароля, смена цвета профиля, вывод всех пользователей, а так же имеются хештеги.

## О приложении:
- Пользователь не авторизованный может задать вопрос
- Авторизованный пользователь так же может задавать вопросы, и редактировать их
- Переход по хештегам может быть как из вопроса, так и из главной страницы
- Под каждым авторизованным вопросом выводится никнейм создателя вопроса
- В профиле изменяется цвет шапки

## Как воспользоваться:
1. Перейти по ссылке и попробовать задать вопрос.
2. Или же:
  - сделать клонирование репозитория
  ```
  git@github.com:MarvinProg/inquirer.git
  ```
  - установить гемы
  ```
  bundle
  ```
  - сделать миграции 
  ```
  rake db:migrate
  ```
  - Создать файл `.env` и положить в него код (а так же перейти в [recaptcha](https://www.google.com/recaptcha/about/) и скопировать ключи)
    ```yml
    RECAPTCHA_INQUIRER_PUBLIC_KEY = ''
    RECAPTCHA_INQUIRER_PRIVATE_KEY = ''
    ```
3. Запустить локальный сервер 
   ```
   rails s
   ```

## Версия Ruby - 2.7.2

