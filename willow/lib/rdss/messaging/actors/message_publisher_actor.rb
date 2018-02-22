module Rdss
  module Messaging
    module Actors
      class MessagePublisherActor < Hyrax::Actors::AbstractActor
        include Wisper::Publisher

        def create(env)
          next_actor.create(env)
        end
        
        def update(env)
          next_actor.update(env)
        end

        def destroy(env)
          next_actor.destroy(env)
        end
      end
    end
  end
end
