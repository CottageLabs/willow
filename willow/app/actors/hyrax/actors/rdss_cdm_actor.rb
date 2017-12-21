# Generated via
#  `rails generate hyrax:work RdssCdm`
module Hyrax
  module Actors
    class RdssCdmActor < Hyrax::Actors::BaseActor
      def create(env)
        add_object_uuid(env)
        title_to_array(env)
        super
      end

      def update(env)
        title_to_array(env)
        super
      end

      private
        def add_object_uuid(env)
          unless env.attributes.key?(:object_uuid)
            env.attributes[:object_uuid] = SecureRandom.uuid
          end
          true
        end

        def title_to_array(env)
          env.attributes[:title] = Array(env.attributes[:title]) if env.attributes[:title]
          true
        end
    end
  end
end
