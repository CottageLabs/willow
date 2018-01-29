module Cdm
  module Concerns
    module ModelExtensions
      extend ActiveSupport::Concern

      included do
        # Define relationship with rdss_cdm model
        # predicate taken from https://github.com/samvera/hydra/wiki/Lesson---Define-Relationships-Between-Objects
        belongs_to :rdss_cdm, predicate: ActiveFedora::RDF::Fcrepo::RelsExt.isPartOf
      end
    end
  end
end