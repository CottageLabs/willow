require "./lib/vocabularies/rioxxterms"
class ProjectStatement < ActiveTriples::Resource
  include CommonMethods

  # configure type: ::RDF::Vocab::MODS.adminMetadata
  property :identifier, predicate: ::RDF::Vocab::Identifiers.local
  property :funder_name, predicate: RioxxTerms.funder_name

  ## Necessary to get AT to create hash URIs.
  def initialize(uri, parent)
    if uri.try(:node?)
      uri = RDF::URI("#project#{uri.to_s.gsub('_:', '')}")
    elsif uri.start_with?("#")
      uri = RDF::URI(uri)
    end
    super
  end

end
