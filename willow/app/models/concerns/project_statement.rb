require "./lib/vocabularies/rioxxterms"
require "./lib/vocabularies/arpfo"
class ProjectStatement < ActiveTriples::Resource
  include CommonMethods

  configure type: Arpfo.Project
  property :identifier, predicate: ::RDF::Vocab::Identifiers.local
  property :title, predicate: ::RDF::Vocab::DC.title
  property :funder_name, predicate: RioxxTerms.funder_name
  property :funder_id, predicate: RioxxTerms.funder_id
  property :grant_number, predicate: Arpfo.grant_number

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
