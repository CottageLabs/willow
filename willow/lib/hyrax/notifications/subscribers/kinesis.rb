require 'aws-sdk'

module Hyrax
  module Notifications
    module Subscribers
      class Kinesis < Subscriber

        def self.register_aws(events: [Events::METADATA_CREATE, Events::METADATA_UPDATE, Events::METADATA_DELETE],
            region: 'eu-west-1',
            stream_name: 'willow-message-stream', shard_count: 1, partition_key: 'willow')

          # verify that the Amazon AWS credentials are set
          unless ENV['AWS_ACCESS_KEY_ID'].present?
            puts('Cannot register Kinesis subscriber because env variable AWS_ACCESS_KEY_ID is not set')
            return
          end

          unless ENV['AWS_SECRET_ACCESS_KEY'].present?
            puts('Cannot register Kinesis subscriber because env variable AWS_SECRET_ACCESS_KEY is not set')
            return
          end

          @subscriber = self.new(region, stream_name, shard_count, partition_key).subscribe(events)
        end

        def self.register_kinesalite(events: [Events::METADATA_CREATE, Events::METADATA_UPDATE, Events::METADATA_DELETE],
            endpoint: nil, region: 'nowhere',
            stream_name: 'willow-message-stream', shard_count: 1, partition_key: 'willow')

          # verify that the Amazon AWS credentials are set
          unless endpoint.present?
            puts('Cannot register Kinesalite subscriber because MESSAGE_STREAM_ENDPOINT is not set')
            return
          end

          @subscriber = self.new(region, stream_name, shard_count, partition_key, endpoint).subscribe(events)
        end


        # loosely based on https://github.com/awslabs/amazon-kinesis-client-ruby/blob/master/samples/sample_kcl_producer.rb
        def initialize(region, stream_name, shard_count, partition_key, endpoint=nil)
          if endpoint.present?
            @client = Aws::Kinesis::Client.new(region: region, endpoint: endpoint)
          else
            @client = Aws::Kinesis::Client.new(region: region)
          end
          @stream_name = stream_name
          @shard_count = shard_count
          @partition_key = partition_key
          create_stream_if_not_exists
        end

        def notify(event, start, finish, id, payload)
          message = BuildMessage.new(event, payload).to_message
          Rails.logger.info("Sending Hyrax event to stream #{@stream_name}: #{message}")
          @client.put_record(stream_name: @stream_name,
                              partition_key: @partition_key,
                              data: JSON.generate(message))
        end



        private
        def create_stream_if_not_exists
          begin
            desc = get_stream_description
            if desc[:stream_status] == 'DELETING'
              fail "Stream #{@stream_name} is being deleted. Please enter another stream name or wait for the delete operation to complete."
            elsif desc[:stream_status] != 'ACTIVE'
              wait_for_stream_to_become_active
            end
            if @shard_count && desc[:shards].size != @shard_count
              fail "Stream #{@stream_name} has #{desc[:shards].size} shards, while requested number of shards is #{@shard_count}"
            end
            puts "Stream #{@stream_name} already exists with #{desc[:shards].size} shards"
          rescue Aws::Kinesis::Errors::ResourceNotFoundException
            puts "Creating stream #{@stream_name} with #{@shard_count || 1} shards"
            @client.create_stream(:stream_name => @stream_name, :shard_count => @shard_count || 1)
            wait_for_stream_to_become_active
          end
        end

        def get_stream_description
          r = @client.describe_stream(:stream_name => @stream_name)
          r[:stream_description]
        end

        def wait_for_stream_to_become_active
          sleep_time_seconds = 3
          status = get_stream_description[:stream_status]
          while status && status != 'ACTIVE' do
            puts "#{@stream_name} has status: #{status}, sleeping for #{sleep_time_seconds} seconds"
            sleep(sleep_time_seconds)
            status = get_stream_description[:stream_status]
          end
        end

      end
    end
  end
end
