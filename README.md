# docker-rails
## Complete Docker configuration for Rails applications

Easy usable, complete docker configuration for rails applications. Less configuration, all-in-one stack.

![Docker](http://blog.docker.com/wp-content/uploads/2013/08/KuDr42X_ITXghJhSInDZekNEF0jLt3NeVxtRye3tqco.png)

## What's included?

- ruby, rbenv, rails, node.js (for asset pipeline), git
- nginx, unicorn, foreman
- beanstald, apache solr
- mysql, redis

## Usage

- Clone the repository from the master branch.
- Create `Dockerfile` to your project and paste below code.

```
# Dockerfile
FROM seyhunak/docker-rails
MAINTAINER seyhunak(seyhunak@gmail.com)

EXPOSE 80
```

## Using with Kitematic

Kitematic is a OSX applications, it provides easiest way to start using Docker on your Mac.
Download and Install on your Mac.

To use as image, just download the repository master branch. Open Kitematic > Create new Image > Select docker-rails folder.
Click "Create Image".


## Build Phase

```
# Build your Dockerfile
$ docker build -t your/app .

# Run Container
$ docker run -d -p 80:80 -e SECRET_KEY_BASE=secretkey your/project
```

## Customize Nginx, Unicorn, foreman config

### Nginx

```
### Dockerfile
We added default nginx configuration, so you can edit your own custom configuration.
(Default path is: /home/rails/)

...
ADD nginx_sites.conf /etc/nginx/sites-enabled/default
...
```

### Unicorn
We added default unicorn configuration, so add your own custom unicorn configuration.
Place "unicorn.rb" we provided to `config/unicorn.rb`

...
ADD unicorn.rb /home/rails/config/unicorn.rb
...


### Foreman

Place "Procfile we provided to your app root.


## License

Copyright (c) 2014 Seyhun Akyürek

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
