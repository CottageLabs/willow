class PublicationStatement < ActiveTriples::Resource

  configure type: ::RDF::Vocab::BIBO.AcademicArticle
  property :title, predicate: ::RDF::Vocab::DC.title
  property :url, predicate: ::RDF::Vocab::BIBO.uri
  property :journal, predicate: ::RDF::Vocab::DC.isPartOf

  ## Necessary to get AT to create hash URIs.
  def initialize(uri, parent)
    if uri.try(:node?)
      uri = RDF::URI("#publication#{uri.to_s.gsub('_:', '')}")
    elsif uri.start_with?("#")
      uri = RDF::URI(uri)
    end
    super
  end

  def final_parent
    parent
  end

  def persisted?
    !new_record?
  end

  def new_record?
    id.start_with?('#')
  end

end
