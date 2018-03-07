module Rdss
  module Actors
    class AnyFieldsChanged
      class << self
        def call(env)
          env.curation_concern.attributes = env.attributes.except(:version).except(:remote_files).except(:uploaded_files)
          changed = env.curation_concern.changed?
          env.curation_concern.reload
          changed
        end
      end
    end
  end
end
