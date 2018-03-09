class ObjectVersionChanged
  class << self
    def call(env)
      ::Rdss::Actors::HashChanged.(env.attributes[:object_version], env.curation_concern.object_version)
    end
  end
end
