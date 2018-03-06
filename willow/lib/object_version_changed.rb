class ObjectVersionChanged
  class << self
    def call(env)
      env.attribute[:object_version].present? && env.curation_concern.object_version != env.attributes[:object_version]
    end
  end
end
