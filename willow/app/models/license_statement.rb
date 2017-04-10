class LicenseStatement < ActiveTriples::Resource

  configure type: ::RDF::Vocab::DC.RightsStatement
  property :label, predicate: ::RDF::Vocab::SKOS.prefLabel
  property :definition, predicate: ::RDF::Vocab::SKOS.definition
  property :webpage, predicate: ::RDF::Vocab::FOAF.page

  QUALIFIERS = ['cc-0', 'cc-by', 'cc-sa'].freeze

  def self.qualifiers
    QUALIFIERS
  end

  ## Necessary to get AT to create hash URIs.
  def initialize(uri, parent)
    if uri.try(:node?)
      uri = RDF::URI("#license#{uri.to_s.gsub('_:', '')}")
    elsif uri.start_with?("#")
      uri = RDF::URI(uri)
    end
    super
  end

  def final_parent
    parent
  end

  def persisted?
    !new_record?
  end

  def new_record?
    id.start_with?('#')
  end

end
