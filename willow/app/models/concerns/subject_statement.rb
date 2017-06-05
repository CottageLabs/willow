class SubjectStatement < ActiveTriples::Resource
  include CommonMethods

  # configure type: ::RDF::Vocab::PROV.Association
  property :label, predicate: ::RDF::Vocab::SKOS.prefLabel
  property :definition, predicate: ::RDF::Vocab::SKOS.definition
  property :classification, predicate: ::RDF::Vocab::MODS.classification
  property :homepage, predicate: ::RDF::Vocab::FOAF.homepage

  ## Necessary to get AT to create hash URIs.
  def initialize(uri, parent)
    if uri.try(:node?)
      uri = RDF::URI("#subject#{uri.to_s.gsub('_:', '')}")
    elsif uri.start_with?("#")
      uri = RDF::URI(uri)
    end
    super
  end

end
