<b>Setup instructions</b>

Prerequisites:

    - Rails 5
    - psql

--After copying .envrc file into the repo install direnv
```sh
$ brew install direnv
$ direnv allow
```    

--database set up
```sh
$ rake db:create
$ rake db:migrate
```
- - - or - - -

```sh
$ rake db:setup
```

--To start the server (port:3000)
```sh
$ rails s
```
