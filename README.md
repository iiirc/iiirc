# iiirc [![BuildStatus](https://secure.travis-ci.org/iiirc/iiirc.png)](http://travis-ci.org/iiirc/iiirc) [![Coverage Status](https://coveralls.io/repos/iiirc/iiirc/badge.png)](https://coveralls.io/r/iiirc/iiirc) [![Code Climate](https://codeclimate.com/github/iiirc/iiirc.png)](https://codeclimate.com/github/iiirc/iiirc)

iiirc is running on http://iiirc.org/

## Current supported IRC log formats

* LimeChat (Mac & Win)
* Weechat
* Textual
* hitode909 format

Always welcome requests and/or patches.

## Development

### dependencies

#### phantomjs

 * [Installing PhantomJS](https://github.com/jonleighton/poltergeist#installing-phantomjs)

### Setup

```
$ git clone git@github.com:iiirc/iiirc.git
$ cd iiirc
$ bundle
$ ./setup.rb
$ bundle exec rake db:create db:migrate
$ r s
```

#### with powder

```
$ gem install powder
$ powder link
$ open http://iiirc.dev
```

### Test

```
$ bundle exec rake spec
```
