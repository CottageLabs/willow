class CurationConcernApproved
  class << self
    def call(env)
      env.curation_concern.state == Vocab::FedoraResourceStatus.active
    end
  end
end
