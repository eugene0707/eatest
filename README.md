### Пример кода "Кадровое агентство"

**Демо-сайт:** http://eatest.herokuapp.com

**Справка по JSON API:** http://eatest.herokuapp.com/api/docs

**Покрытие тестами:** http://eatest.herokuapp.com/coverage/index.html


####Использовано: 
1. Ruby 2.1.5
2. Rails 4.2.2
3. Rspec 3.3.0
4. PostgreSQL
5. AngularJS 1.4.7
6. Bootstrap 3.3

####Запуск на локального стенда

1. bundle install
2. npm install
3. настроить config/database.yml на свою БД Postgres
4. bundle exec rake db:setup
5. bundle exec rails s

####Деплой на Heroku

1. heroku buildpacks:set https://github.com/ddollar/heroku-buildpack-multi.git
2. git push heroku master



