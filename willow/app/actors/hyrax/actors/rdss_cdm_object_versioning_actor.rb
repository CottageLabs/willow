module Hyrax
  module Actors
    class RdssCdmObjectVersioningActor < AbstractActor

      def create(env)
        perform_object_versioning(env)
        next_actor.create(env)
      end

      def update(env)
        perform_object_versioning(env)
        next_actor.update(env)
      end

      private

      def perform_object_versioning(env)
        attach_object_version_changed_property(env)
        increment_object_version(env) if should_increment_object_version?(env)
      end

      def attach_object_version_changed_property(env)
        class << env
          attr_accessor :object_version_changed
          alias_method :object_version_changed?, :object_version_changed
        end
        env.object_version_changed = false
      end

      def should_increment_object_version?(env)
        env.attributes[:object_version] == "" ||
          (curation_concern_approved?(env.curation_concern) &&
            significant_fields_changed?(env))
      end

      def curation_concern_approved?(curation_concern)
        curation_concern.state == Vocab::FedoraResourceStatus.active
      end

      def significant_fields_changed?(env)
        env.curation_concern.title != env.attributes[:title] ||
          env.attributes[:uploaded_files].count.positive?
      end

      def increment_object_version(env)
        if env.attributes[:object_version] == ""
          env.attributes[:object_version] = "0"
        end

        env.attributes[:object_version] =
            (env.attributes[:object_version].to_i + 1).to_s

        env.object_version_changed = true
      end
    end
  end
end