web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
worker: bundle exec backburner -q default -d -P /var/run/backburner.pid -l /var/log/backburner.log
solr: bundle exec rake sunspot:solr:run