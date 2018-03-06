module Rdss
  module Actors
    class AnyFieldsChanged
      class << self
        def call(env)
          work_copy = env.curation_concern.clone
          work_copy.attributes = env.attributes.except(:version).except(:remote_files).except(:uploaded_files)
          work_copy.changed?
        end
      end
    end
  end
end
