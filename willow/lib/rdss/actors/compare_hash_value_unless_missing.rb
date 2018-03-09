module Rdss
  module Actors
    class CompareHashValueUnlessMissing
      class << self
        def call(attribute, value)
          attribute.nil? || attribute == value
        end
      end
    end
  end
end

