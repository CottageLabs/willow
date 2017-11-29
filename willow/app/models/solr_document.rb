# frozen_string_literal: true
class SolrDocument
  include Blacklight::Solr::Document
  include Blacklight::Gallery::OpenseadragonSolrDocument

  # Adds Hyrax behaviors to the SolrDocument.
  include Hyrax::SolrDocumentBehavior


  # self.unique_key = 'id'

  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension(Blacklight::Document::Email)

  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension(Blacklight::Document::Sms)

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)

  # Do content negotiation for AF models.

  use_extension( Hydra::ContentNegotiation )

  def doi
    self[Solrizer.solr_name('doi', :stored_searchable)]
  end

  def other_title
    self[Solrizer.solr_name('other_title', :displayable)]
  end

  def creator_nested
    self[Solrizer.solr_name('creator_nested', :displayable)]
  end

  def date
    self[Solrizer.solr_name('date', :displayable)]
  end

  def license_nested
    self[Solrizer.solr_name('license_nested', :displayable)]
  end

  def relation
    self[Solrizer.solr_name('relation', :displayable)]
  end

  def subject_nested
    self[Solrizer.solr_name('subject_nested', :displayable)]
  end

  def admin_metadata
    self[Solrizer.solr_name('admin_metadata', :displayable)]
  end

  def coverage
    self[Solrizer.solr_name('coverage', :stored_searchable)]
  end

  def apc
    self[Solrizer.solr_name('apc', :stored_searchable)]
  end

  def tagged_version
    self[Solrizer.solr_name('tagged_version', :stored_searchable)]
  end

  def project
    self[Solrizer.solr_name('project', :displayable)]
  end

  def identifier_nested
    self[Solrizer.solr_name('identifier_nested', :displayable)]
  end

  def category
    self[Solrizer.solr_name('category', :stored_searchable)]
  end

  def rating
    self[Solrizer.solr_name('rating', :stored_searchable)]
  end

  def rights_holder
    self[Solrizer.solr_name('rights_holder', :stored_searchable)]
  end

  def organisation_nested
    self[Solrizer.solr_name('organisation_nested', :displayable)]
  end

  def preservation_nested
    self[Solrizer.solr_name('preservation_nested', :displayable)]
  end

  def rdss_version
    self[Solrizer.solr_name('rdss_version', :stored_searchable)]
  end

end
