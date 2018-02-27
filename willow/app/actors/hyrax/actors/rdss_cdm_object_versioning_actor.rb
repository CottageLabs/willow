module Hyrax
  module Actors
    class RdssCdmObjectVersioningActor < AbstractActor
      def create(env)
        env.attributes[:object_version]='1' if env.attributes[:object_version].empty?
        next_actor.create(env)
      end

      def update(env)
        env.attributes[:object_version].next! if CurationConcernApproved.(env) && SignificantFieldsChanged.(env) unless ObjectVersionChanged.(env)
        next_actor.update(env)
      end
    end
  end
end