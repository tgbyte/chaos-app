require 'bundler'
Bundler.require(:default)
require 'sinatra/reloader' if development?

REDIS_HOST = 'redis'

configure do
  set :server, :puma
  set :bind, '0.0.0.0'
end

redis = Redis.new(host: REDIS_HOST)
"Hello, Redis! ##{redis.incr('starts')}"

get '/' do
  redis = Redis.new(host: REDIS_HOST)
  "Hello, Chaos! [req# #{redis.incr('counter')}, start# #{redis.get('starts')}]"
end

get '/fortune' do
  FortuneGem.give_fortune
end
