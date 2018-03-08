module Cdm
  module Messaging
    class FileStorageLocation < MessageMapper
      def value(object)
        Hyrax::Engine.routes.url_helpers.download_url(object, host: (ENV['SAMVERA_INTERNAL_HOST'] || Rails.application.routes.default_url_options[:host]))
      end
    end
  end
end
