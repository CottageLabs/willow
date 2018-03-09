# Generated via
#  `rails generate hyrax:work RdssCdm`
module Hyrax
  module Actors
    class RdssCdmActor < Hyrax::Actors::BaseActor
#TODO #PMAK Should we set initial value for :object_version here too?
      def default_values
        {
          object_value:   'normal',
        }
      end

      public
      def create(env)
        ::Rdss::Actors::SetAttributeValuesIfBlank.(env, default_values)
        super
      end
    end
  end
end
