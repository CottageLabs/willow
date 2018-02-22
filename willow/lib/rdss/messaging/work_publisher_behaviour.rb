module Rdss
  module Messaging
    module WorkPublisherBehaviour
      extend ActiveSupport::Concern 
      include Wisper::Publisher

      included do 

        after_save do 
          if approval_save?
            broadcast("#{broadcast_name}_approved".to_sym, self)
          end
        end

        def broadcast_name
          @class.name.demodulize.underscore
        end

        def approval_save?
          state_changed? and @state = Vocab::FedoraResourceStatus.active
        end
      end
    end
  end
end
