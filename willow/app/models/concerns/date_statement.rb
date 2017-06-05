class DateStatement < ActiveTriples::Resource
  include CommonMethods

  configure type: ::RDF::Vocab::VCARD.Date
  property :date, predicate: ::RDF::Vocab::DC.date
  property :description, predicate: ::RDF::Vocab::DC.description

  QUALIFIERS = {
    'Accepted' => ::RDF::Vocab::DC.dateAccepted,
    'Available' => 'Available',
    'Copyrighted' => ::RDF::Vocab::Bibframe.copyrightDate,
    'Collected' => 'Collected',
    'Created' => ::RDF::Vocab::DC.created,
    'Issued' => ::RDF::Vocab::DC.issued,
    'Submitted' => ::RDF::Vocab::DC.dateSubmitted,
    'Updated' => ::RDF::Vocab::Bibframe.changeDate,
    'Valid' => ::RDF::Vocab::DC.valid
  }

  def self.qualifiers
    QUALIFIERS
  end


  ## Necessary to get AT to create hash URIs.
  def initialize(uri, parent)
    if uri.try(:node?)
      uri = RDF::URI("#date#{uri.to_s.gsub('_:', '')}")
    elsif uri.start_with?("#")
      uri = RDF::URI(uri)
    end
    super
  end

end
