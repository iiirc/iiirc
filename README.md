# iiirc [![BuildStatus](https://secure.travis-ci.org/iiirc/iiirc.png)](http://travis-ci.org/iiirc/iiirc)

## dependencies

### phantomjs
 * [Installing PhantomJS](https://github.com/jonleighton/poltergeist#installing-phantomjs)

## Setup

```
$ git clone git@github.com:iiirc/iiirc.git
$ cd iiirc
$ bundle
$ bundle exec rake setup
$ bundle exec rake db:create db:migrate
$ r s
```

### with powder

```
$ gem install powder
$ powder link
$ open http://iiirc.dev
```

## Test

```
$ bundle exec rake spec
```
