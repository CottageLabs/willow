# Generated via
#  `rails generate hyrax:work RdssCdm`
module Hyrax
  module Actors
    class RdssCdmActor < Hyrax::Actors::BaseActor
#TODO #PMAK Should we set initial value for :object_version here too?
      def default_values
        {
          object_value:   :normal,
          object_uuid:    SecureRandom.uuid
        }
      end

      public
      def create(env)
        ::Rdss::Actors::SetAttributeValuesIfBlank.(env, default_values)
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
    end
  end
end
