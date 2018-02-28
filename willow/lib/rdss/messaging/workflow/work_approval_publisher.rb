module Rdss
  module Messaging
    module Workflow
      class WorkApprovalPublisher
        include Wisper::Publisher

        class << self
          def call(target:, **)
            new.call(target: target)
          end
        end

        def call(target:)
          broadcast(:work_approval, target)
        end
      end
    end
  end
end

