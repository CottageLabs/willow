module Rdss
  module Actors
    class SetHashValuesIfBlank < SetHashValues
      def call(hash)
        hash.each do |key, value|
          attributes[key]=value if attributes[key].blank?
        end
      end
    end
  end
end