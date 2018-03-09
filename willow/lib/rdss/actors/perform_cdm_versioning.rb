module Rdss
  module Actors
    class PerformCdmVersioning
      class << self
        def call(env)
          record_current_uuid(env)
          env.attributes[:object_uuid] = SecureRandom.uuid
          env.attributes[:object_version] = env.curation_concern.object_version.succ 
        end

        private
        def current_uuid(env)
          env.curation_concern.object_uuid
        end

        def record_current_uuid(env)
          ::Rdss::Actors::AppendToNumberedHash.(
            env.attributes, 
            {object_related_identifiers_attributes: build_is_new_version_of(current_uuid(env))}
          )
        end

        def build_is_new_version_of(uuid) 
          {
            _destroy: 'false', 
            relation_type: 'is_new_version_of', 
            identifier_attributes: {
              identifier_value: uuid, 
              identifier_type: 'source_id'
            }
          }
        end
      end
    end
  end
end
