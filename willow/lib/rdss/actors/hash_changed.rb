module Rdss
  module Actors
    class HashChanged
      class << self
        def call(attribute, value)
          !::Rdss::Actors::CompareHashValueUnlessMissing.(attribute, value)
        end
      end
    end
  end
end
