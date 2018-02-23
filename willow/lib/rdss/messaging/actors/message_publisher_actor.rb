module Rdss
  module Messaging
    module Actors
      class MessagePublisherActor < Hyrax::Actors::AbstractActor
        include Wisper::Publisher
        
        def update(env)
          next_actor.update(env)
          broadcast(:work_update_minor, env.curation_concern)
        end

        def destroy(env)
          next_actor.destroy(env)
          broadcast(:work_destroy, env.curation_concern)
        end
      end
    end
  end
end
