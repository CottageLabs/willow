Sufia::Notifications::Subscribers::Log.register

# only register AWS message streaming if specified by environmental variables
if ENV['AWS_MESSAGE_STREAM'] == 'true'
  Sufia::Notifications::Subscribers::Kinesis.register(region: ENV['AWS_MESSAGE_STREAM_REGION'],
                                                      stream_name: ENV['AWS_MESSAGE_STREAM_NAME'],
                                                      shard_count: ENV['AWS_MESSAGE_STREAM_SHARD_COUNT'].to_i,
                                                      partition_key: ENV['AWS_MESSAGE_STREAM_PARTITION_KEY'])
else
  puts("Not registering AWS Message Stream: #{ENV['AWS_MESSAGE_STREAM']}")
end

