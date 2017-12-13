# Generated via
#  `rails generate hyrax:work RdssCdm`
module Hyrax
  module Actors
    class RdssCdmActor < Hyrax::Actors::BaseActor
      def create(env)
        add_object_uuid(env)
        super
      end

      private
        def add_object_uuid(env)
          unless env.attributes.key?(:object_uuid)
            env.attributes[:object_uuid] = SecureRandom.uuid
          end
          true
        end
    end
  end
end
