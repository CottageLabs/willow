module Cdm
  module Messaging
    class ObjectRights
      class << self
        private
        def decoders
          %i(
            rightsStatement
            rightsHolder
            license
            access
          )
        end

        public
        def call(object)
          decoders.reduce({}) {|master, decoder| master.update("::Cdm::Messaging::#{decoder.to_s.classify}".constantize.(object))}
        end
      end
    end
  end
end