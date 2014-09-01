# DOCKER-VERSION 1.2.0

FROM       ubuntu:14.04
MAINTAINER Seyhun Akyurek "seyhunak@gmail.com"

# Install dependency packages
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y software-properties-common
RUN apt-get install -y make gcc wget openjdk-6-jre
RUN apt-get install -y git
RUN apt-get clean

# Deploy rbenv and ruby-build
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
ENV RBENV_ROOT /root/.rbenv
ENV PATH /root/.rbenv/bin:/root/.rbenv/shims:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ADD ./rbenv.sh /etc/profile.d/rbenv.sh

# Install Ruby
RUN rbenv install 2.1.2
RUN rbenv global 2.1.2
RUN rbenv rehash

# Install Bundler
RUN gem install --no-ri --no-rdoc bundler

# Install Rails
RUN gem install rails-4.2.0.beta1

# Install Curl and Node.js (for asset pipeline)
RUN apt-get install -qq -y curl
RUN apt-get install -qq -y nodejs

# Install nginx
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN apt-get install -qq -y nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx
ADD nginx_sites.conf /etc/nginx/sites-enabled/default

# Publish port 80
EXPOSE 80

# Start nginx when container starts
ENTRYPOINT /usr/sbin/nginx

# Install foreman
RUN gem install foreman

# Add default foreman config
ADD Procfile /home/rails/Procfile

# Install Unicorn
RUN gem install unicorn

# Add default unicorn config
ADD unicorn.rb /home/rails/config/unicorn.rb

# Install Beanstalkd
RUN apt-get install -qq -y beanstalkd

# Install backburner
RUN gem install backburner

# Add default unicorn config
ADD backburner.rb /home/rails/config/initializers/backburner.rb

# Install Solr
RUN wget http://archive.apache.org/dist/lucene/solr/3.6.2/apache-solr-3.6.2.tgz -O /tmp/pkg.tar.gz
RUN (cd /tmp && tar zxf pkg.tar.gz && mv apache-solr-* /opt/solr)
RUN rm -rf /tmp/*
ADD run.sh /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
EXPOSE 8983
CMD ["/usr/local/bin/run"]

# Install Solr
RUN gem install sunspot
RUN gem install sunspot_solr
RUN gem install sunspot_rails

# Install MySQL (for mysql, mysql2 gem)
RUN apt-get install -qq -y libmysqlclient-dev
RUN gem install mysql2

# Install Redis
RUN apt-get install -qq -y python-pip redis-server

# Setting up Rails app
WORKDIR /home/rails
ONBUILD ADD Gemfile /home/rails/Gemfile
ONBUILD ADD Gemfile.lock /home/rails/Gemfile.lock
ONBUILD RUN bundle install --without development test
ONBUILD ADD . /home/rails

# Set ENV Variables
ENV RAILS_ENV production

CMD bundle exec rake assets:precompile && foreman start -f Procfile