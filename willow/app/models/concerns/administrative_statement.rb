class AdministrativeStatement < ActiveTriples::Resource

  # configure type: ::RDF::Vocab::MODS.adminMetadata
  property :question, predicate: ::RDF::Vocab::DISCO.question
  property :response, predicate: ::RDF::Vocab::SIOC.has_reply

  ## Necessary to get AT to create hash URIs.
  def initialize(uri, parent)
    if uri.try(:node?)
      uri = RDF::URI("#admin_metadata#{uri.to_s.gsub('_:', '')}")
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
