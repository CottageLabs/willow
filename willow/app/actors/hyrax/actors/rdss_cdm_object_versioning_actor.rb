module Hyrax
  module Actors
    class RdssCdmObjectVersioningActor < AbstractActor
      def create(env)
        env.attributes[:object_version]='1' if env.attributes[:object_version].empty? #Not sure the guard is needed
        next_actor.create(env)
      end

      def update(env)
        env.attributes[:object_version].next! if CurationConcernApproved.(env) && SignificantFieldsChanged.(env) unless ObjectVersionChanged.(env)
        #Not just a refactor, so check if the unless clause is actually necessary, but it felt correct when I was writing it.
        next_actor.update(env)
      end
    end
  end
end