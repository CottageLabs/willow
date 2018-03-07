module Rdss
  module Messaging
    module Actors
      class MessagePublisherActor < Hyrax::Actors::AbstractActor
        include Wisper::Publisher
        
        def update(env)
          #Do this while the old creation_concern is still in scope before calling the next_actor which will persist it.
          update_occured = ObjectVersionChanged.(env)
          next_actor.update(env)
          broadcast(:work_update, env.curation_concern) if update_occured && CurationConcernApproved.(env)
        end

        def destroy(env)
          broadcast(:work_destroy, env.curation_concern) if CurationConcernApproved.(env)
          next_actor.destroy(env)
        end
      end
    end
  end
end
