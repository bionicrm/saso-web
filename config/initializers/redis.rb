$redis_databases = {
    preferences: 0,
    concurrent_connections: 1
}
$redis = Redis.new host: ENV['REDIS_HOST'], port: ENV['REDIS_PORT']
password = ENV['REDIS_PASSWORD']

if password != ''
  $redis.auth password
end
