class PersonStatement < ActiveTriples::Resource
  include CommonMethods

  configure type: ::RDF::Vocab::FOAF.Person
  property :first_name, predicate: ::RDF::Vocab::FOAF.givenName
  property :last_name, predicate: ::RDF::Vocab::FOAF.familyName
  # property :identifier, predicate: ::RDF::Vocab::DataCite.hasIdentifier
  # property :identifier_scheme, predicate: ::RDF::Vocab::DataCite.usesIdentifierScheme
  property :orcid, predicate: ::RDF::Vocab::DataCite.orcid
  property :role, predicate: ::RDF::Vocab::MODS.roleRelationship
  property :affiliation, predicate: ::RDF::Vocab::VMD.affiliation

  ## Necessary to get AT to create hash URIs.
  def initialize(uri, parent)
    if uri.try(:node?)
      uri = RDF::URI("#person#{uri.to_s.gsub('_:', '')}")
    elsif uri.start_with?("#")
      uri = RDF::URI(uri)
    end
    super
  end

end
