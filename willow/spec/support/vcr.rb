require 'active_support/core_ext/numeric/time'
require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  #the directory where your cassettes will be saved
  config.cassette_library_dir = 'spec/fixtures/vcr'
  # your HTTP request service.
  config.hook_into :webmock
  config.default_cassette_options = { match_requests_on: [:method, :uri],
                                      record: ENV["VCR_RECORD_MODE"] ? ENV["VCR_RECORD_MODE"].to_sym : :once }

  config.configure_rspec_metadata!
end

WebMock.disable_net_connect!(allow_localhost: true)
