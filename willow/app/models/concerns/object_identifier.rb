class ObjectIdentifier < ActiveTriples::Resource
  include CommonMethods

  property :obj_id_scheme, predicate: ::RDF::Vocab::DataCite.usesIdentifierScheme
  property :obj_id, predicate: ::RDF::Vocab::DataCite.hasIdentifier

  ## Necessary to get AT to create hash URIs.
  def initialize(uri, parent)
    if uri.try(:node?)
      uri = RDF::URI("#identifier#{uri.to_s.gsub('_:', '')}")
    elsif uri.start_with?("#")
      uri = RDF::URI(uri)
    end
    super
  end

end
