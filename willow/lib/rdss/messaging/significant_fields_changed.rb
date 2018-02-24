module Rdss
  class SignificantFieldsChanged
    class << self
      def call(env)
        env.creation_concern.title != env.attributes[:title] || env.attributes[:uploaded_files].present?
      end
    end
  end
end