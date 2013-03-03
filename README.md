# iiirc [![BuildStatus](https://secure.travis-ci.org/iiirc/iiirc.png)](http://travis-ci.org/iiirc/iiirc)

## setup

```
$ git clone git@github.com:iiirc/iiirc.git
$ cd iiirc
$ gem install powder # if you use pow
$ bundle
$ bundle exec rake setup
$ bundle exec rake db:create db:migrate
$ r s # see http://0.0.0.0:3000

$ bundle exec rake spec # you can test if u want

$ powder link # if you use pow
$ open http://iiirc.dev
```
