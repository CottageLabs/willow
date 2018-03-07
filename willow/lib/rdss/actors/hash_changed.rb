module Rdss
  module Actors
    class HashChanged
      class << self
        def call(hash_value, value)
          !::Rdss::Actors::CompareHashValueUnlessMissing.(hash_value, value)
        end
      end
    end
  end
end
