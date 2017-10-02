class OrganisationStatement < ActiveTriples::Resource
  include CommonMethods

  configure type: ::RDF::Vocab::ORG.Organization
  property :name, predicate: ::RDF::Vocab::VCARD.hasName
  # property :org_type, predicate: ::RDF::Vocab::DC.description
  property :role, predicate: ::RDF::Vocab::ORG.role
  property :uri, predicate: ::RDF::Vocab::Identifiers.uri
  property :identifier, predicate: ::RDF::Vocab::Identifiers.local

  ## Necessary to get AT to create hash URIs.
  def initialize(uri, parent)
    if uri.try(:node?)
      uri = RDF::URI("#organisation#{uri.to_s.gsub('_:', '')}")
    elsif uri.start_with?("#")
      uri = RDF::URI(uri)
    end
    super
  end

end
