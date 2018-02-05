module Cdm
  # Active fedora model representing an object date for an rdss_cdm model
  class Date < ActiveFedora::Base
    include Cdm::Concerns::ModelExtensions
    property :date_value, predicate: ::RDF::Vocab::DC.date, multiple: false
    property :date_type, predicate: ::RDF::Vocab::DC.description, multiple: false
    validates :date_type, :date_value, presence: true
  end
end
