

# Getting Started From Bitbucket

```
$ git clone --origin bitbucket git@bitbucket.org:banyan/rfckun.git
Cloning into 'rfckun'...
remote: Counting objects: 204, done.
remote: Compressing objects: 100% (105/105), done.
remote: Total 204 (delta 73), reused 204 (delta 73)
Receiving objects: 100% (204/204), 42.75 KiB, done.
Resolving deltas: 100% (73/73), done.
$ cd rfckun
$ git remote
bitbucket
```

# Setup

```
$ gem install powder # if you use pow
$ bundle
$ bundle exec rake db:create db:migrate
$ r s # see http://0.0.0.0:3000

$ bundle exec rake spec # you can test if u want

$ powder link # if you use pow
$ open http://rfckun.dev
```

# Git With Bitbucket

```
$ # edit edit...
$ git push bitbucket master
```

* it it doesn't work, :fixit:
