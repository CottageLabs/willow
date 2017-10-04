class PreservationStatement < ActiveTriples::Resource
  include CommonMethods

  configure type: ::RDF::Vocab::PREMIS.Event
  property :name, predicate: ::RDF::Vocab::DC.title
  property :event_type, predicate: ::RDF::Vocab::PREMIS.hasEventType
  property :date, predicate: ::RDF::Vocab::PREMIS.hasEventDateTime
  property :description, predicate: ::RDF::Vocab::PREMIS.hasEventDetail
  property :outcome, predicate: ::RDF::Vocab::PREMIS.hasEventOutcome

  ## Necessary to get AT to create hash URIs.
  def initialize(uri, parent)
    if uri.try(:node?)
      uri = RDF::URI("#preservation#{uri.to_s.gsub('_:', '')}")
    elsif uri.start_with?("#")
      uri = RDF::URI(uri)
    end
    super
  end

end
