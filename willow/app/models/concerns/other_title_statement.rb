class OtherTitleStatement < ActiveTriples::Resource
  include CommonMethods

  configure type: ::RDF::Vocab::Bibframe.Title
  property :title, predicate: ::RDF::Vocab::Bibframe.title
  property :title_type, predicate: ::RDF::Vocab::Bibframe.titleQualifier

  QUALIFIERS = [
    'Alternative Title',
    'Subtitle ',
    'TranslatedTitle',
    'Other',
    ].freeze

  def self.qualifiers
    QUALIFIERS
  end

  ## Necessary to get AT to create hash URIs.
  def initialize(uri, parent)
    if uri.try(:node?)
      uri = RDF::URI("#title#{uri.to_s.gsub('_:', '')}")
    elsif uri.start_with?("#")
      uri = RDF::URI(uri)
    end
    super
  end

end
