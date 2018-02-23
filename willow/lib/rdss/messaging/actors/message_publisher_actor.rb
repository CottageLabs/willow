module Rdss
  module Messaging
    module Actors
      class MessagePublisherActor < Hyrax::Actors::AbstractActor
        include Wisper::Publisher
        
        def update(env)
          next_actor.update(env)
          if work_approved?(env)
            broadcast(:work_update_minor, env.curation_concern)
          end
        end

        def destroy(env)
          next_actor.destroy(env)
          if work_approved?(env)
            broadcast(:work_destroy, env.curation_concern)
          end
        end

        private 
          def work_approved?(env)
            env.curation_concern.state == Vocab::FedoraResourceStatus.active
          end

      end
    end
  end
end
