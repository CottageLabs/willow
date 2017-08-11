# this line helps the notifications run in production mode
Hyrax::Notifications::Subscribers::BuildMessage

Hyrax::Notifications::Subscribers::Log.register

# only register AWS message streaming if specified by environmental variables
if ENV['MESSAGE_STREAM'] == 'aws'
  Hyrax::Notifications::Subscribers::Kinesis.register_aws(region: ENV['MESSAGE_STREAM_REGION'],
                                                          stream_name: ENV['MESSAGE_STREAM_NAME'],
                                                          shard_count: ENV['MESSAGE_STREAM_SHARD_COUNT'].to_i,
                                                          partition_key: ENV['MESSAGE_STREAM_PARTITION_KEY'])
elsif ENV['MESSAGE_STREAM'] == 'kinesalite'
  Hyrax::Notifications::Subscribers::Kinesis.register_kinesalite(endpoint: ENV['MESSAGE_STREAM_ENDPOINT'],
                                                                 region: 'nowhere',
                                                                 stream_name: ENV['MESSAGE_STREAM_NAME'],
                                                                 shard_count: ENV['MESSAGE_STREAM_SHARD_COUNT'].to_i,
                                                                 partition_key: ENV['MESSAGE_STREAM_PARTITION_KEY'])
else
  puts("Not registering Message Stream (#{ENV['MESSAGE_STREAM']})")
end

