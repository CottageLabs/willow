module Rdss
  class SignificantFieldsChanged
    class << self
      def call(env)
        env.creation_concern.object_version != env.attributes[:object_version]
      end
    end
  end
end