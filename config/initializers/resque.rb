# from http://stackoverflow.com/questions/9944089/how-to-configure-resque-on-heroku-with-rails-3-1-and-the-asset-pipeline
if Rails.env.staging? || Rails.env.production?
  uri = URI.parse ENV['REDISTOGO_URL']
  Resque.redis = Redis.new :host => uri.host, :port => uri.port, :password => uri.password
end