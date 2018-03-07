module Rdss
  module Actors
    class CompareHashValueUnlessMissing
      class << self
        def call(hash_value, value)
          hash_value.nil? || hash_value == value
        end
      end
    end
  end
end

