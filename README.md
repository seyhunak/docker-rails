# Dockerfile (Complete Docker configuration for Rails applications)

Easy usable, complete docker configuration for rails applications. Less configuration, all-in-one stack.

## What's included?

- ruby, rbenv, rails, node.js (for asset pipeline), git
- nginx, unicorn, foreman
- beanstald, apache solr
- mysql, redis

# Usage

- Clone the repository from the master branch.
- Create `Dockerfile` to your project and paste below code.

```
# Dockerfile
FROM seyhunak/docker-rails
MAINTAINER seyhunak(seyhunak@gmail.com)

EXPOSE 80
```

## Build Phase

```
# Build your Dockerfile
$ docker build -t your/app .

# Run Container
$ docker run -d -p 80:80 -e SECRET_KEY_BASE=secretkey your/project
```

# Customize Nginx, Unicorn, foreman config

## Nginx

```
### Dockerfile
We added default nginx configuration, so you can edit your own custom configuration.
(Default path is: /home/rails/)

...
ADD nginx_sites.conf /etc/nginx/sites-enabled/default
...
```

## Unicorn
We added default unicorn configuration, so add your own custom unicorn configuration.
Place "unicorn.rb" we provided to `config/unicorn.rb`

...
ADD unicorn.rb /home/rails/config/unicorn.rb
...
```
## Foreman

Place "Procfile we provided to your app root.