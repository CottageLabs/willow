class RelationStatement < ActiveTriples::Resource

  configure type: ::RDF::Vocab::PROV.Association
  property :label, predicate: ::RDF::Vocab::SKOS.prefLabel
  property :url, predicate: ::RDF::Vocab::MODS.locationUrl

  ## Necessary to get AT to create hash URIs.
  def initialize(uri, parent)
    if uri.try(:node?)
      uri = RDF::URI("#relation#{uri.to_s.gsub('_:', '')}")
    elsif uri.start_with?("#")
      uri = RDF::URI(uri)
    end
    super
  end

  include CommonMethods
end
