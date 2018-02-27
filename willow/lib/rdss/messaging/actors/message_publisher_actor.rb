module Rdss
  module Messaging
    module Actors
      class MessagePublisherActor < Hyrax::Actors::AbstractActor
        include Wisper::Publisher
        
        def update(env)
          #Do this while the old creation_concern is still in scope before calling the next_actor which will persist it.
          update_type = ObjectVersionChanged.(env) ? :work_update_major : :work_update_minor
          next_actor.update(env)
          broadcast(update_type, env.curation_concern) if CurationConcernApproved.(env)
        end

        def destroy(env)
          broadcast(:work_destroy, env.curation_concern) if CurationConcernApproved.(env)
          next_actor.destroy(env)
        end
      end
    end
  end
end
