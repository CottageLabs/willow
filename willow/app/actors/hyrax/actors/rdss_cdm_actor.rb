# Generated via
#  `rails generate hyrax:work RdssCdm`
module Hyrax
  module Actors
    class RdssCdmActor < Hyrax::Actors::BaseActor
      def create(env)
        add_object_uuid(env)
        super
      end

      # TODO Remove this method
      # DMVB 2018-03-01 We should in theory be able to remove this overridden update 
      # method completely. However, without it I have seen updates fail and return to the
      # edit page. There were no errors in the model and it's as if the super call was returning falsey
      # value. With the method below in place edits have always worked.
      def update(env)
        super
      end

      private
        def add_object_uuid(env)
          unless env.attributes.key?(:object_uuid)
            env.attributes[:object_uuid] = SecureRandom.uuid
          end
        end
    end
  end
end
