module Hyrax
  module Actors
    class RdssCdmObjectVersioningActor < AbstractActor

      def create(env)
        env.attributes[:object_version] = 1
        log_details(env, __method__)
        next_actor.create(env)
      end

      def update(env)
        if significant_fields_changed(env)
          increment_object_version(env)
        end
        log_details(env, __method__)
        next_actor.update(env)
      end

      private

      def log_details(env, from)
        Rails.logger.info "RdssCdmObjectVersioningActor #{from}:
        {
          curation_concern.title: #{env.curation_concern.title},
          attribute.title: #{env.attributes[:title]},
          uploaded_files_count: #{env.attributes[:uploaded_files].count},
          object_version: #{env.attributes[:object_version]},
          significant_fields_changed: #{significant_fields_changed(env)}
        }"
      end

      def significant_fields_changed(env)
        env.curation_concern.title != env.attributes[:title] ||
          env.attributes[:uploaded_files].count.positive?
      end

      def increment_object_version(env)
        env.attributes[:object_version] =
            (env.attributes[:object_version].to_i + 1).to_s
      end
    end
  end
end