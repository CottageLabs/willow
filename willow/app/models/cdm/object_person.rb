class ObjectPerson < ActiveFedora::Base
  property :given_name, predicate: ::RDF::Vocab::FOAF.givenName
  property :family_name, predicate: ::RDF::Vocab::FOAF.familyName
  property :name, predicate: ::RDF::Vocab::VCARD.hasName
  belongs_to :object_person_roles

  #Not sure how many of these we will need.
  property :affiliation, predicate: ::RDF::Vocab::VMD.affiliation
  property :uri, predicate: ::RDF::Vocab::Identifiers.uri
  property :identifier, predicate: ::RDF::Vocab::Identifiers.local

  ## Necessary to get AT to create hash URIs.
  def initialize(uri, parent)
    uri = if uri.try(:node?)
            RDF::URI("#person#{uri.to_s.gsub('_:', '')}")
          elsif uri.start_with?("#")
            RDF::URI(uri)
          else
            uri
          end
    super
  end

end
