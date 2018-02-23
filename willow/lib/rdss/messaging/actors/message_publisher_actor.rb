module Rdss
  module Messaging
    module Actors
      class MessagePublisherActor < Hyrax::Actors::AbstractActor
        include Wisper::Publisher
        
        def update(env)
          next_actor.update(env)
          if curation_concern_approved?(env.curation_concern)
            if env.object_version_changed?
              broadcast(:work_update_major, env.curation_concern)
            else
              broadcast(:work_update_minor, env.curation_concern)
            end
          end
        end

        def destroy(env)
          if curation_concern_approved?(env.curation_concern)
            broadcast(:work_destroy, env.curation_concern)
          end
          next_actor.destroy(env)
        end

        private 

          def curation_concern_approved?(curation_concern)
            curation_concern.state == Vocab::FedoraResourceStatus.active
          end

      end
    end
  end
end
