# Generated via
#  `rails generate curation_concerns:work Article`
require 'rails_helper'

RSpec.describe Article do
  it 'has human readable type article' do
    @obj = Article.new
    @obj.attributes = {
      title: ['test article']
    }
    @obj.save!
    @obj.reload
    expect(@obj.human_readable_type).to eq('Article')
  end

  describe 'title:' do
    it 'requires title' do
      @obj = Article.new
      expect { @obj.save! }.to raise_error
        ('ActiveFedora::RecordInvalid: Validation failed: Title Your work must have a title.')
    end

    it 'has a multi valued title field' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test dataset']
      }
      @obj.save!
      @obj.reload
      expect(@obj.title).to eq ['test dataset']
    end
  end

  describe 'doi' do
    it 'has a single valued doi' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        doi: '0000-0000-0000-0000'
      }
      @obj.save!
      @obj.reload
      expect(@obj.doi).to be_kind_of String
      expect(@obj.doi).to eq '0000-0000-0000-0000'
    end

    it 'indexes doi' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        doi: '0000-0000-0000-0000'
      }
      @doc = @obj.to_solr
      expect(@doc['doi_tesim']).to eq(['0000-0000-0000-0000'])
      expect(@doc['doi_sim']).to eq(['0000-0000-0000-0000'])
    end
  end

  describe 'publisher' do
    it 'has publisher' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        publisher: ['Willow']
      }
      @obj.save!
      @obj.reload
      expect(@obj.publisher).to be_kind_of ActiveTriples::Relation
      expect(@obj.publisher).to eq ['Willow']
    end

    it 'indexes publisher' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        publisher: ['Willow']
      }
      @doc = @obj.to_solr
      expect(@doc['publisher_tesim']).to match_array(['Willow'])
      expect(@doc['publisher_sim']).to match_array(['Willow'])
    end
  end

  describe 'Coverage' do
    it 'has coverage' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        coverage: ['Coverage metadata']
      }
      @obj.save!
      @obj.reload
      expect(@obj.coverage).to be_kind_of ActiveTriples::Relation
      expect(@obj.coverage).to eq ['Coverage metadata']
    end

    it 'indexes coverage' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        coverage: ['Coverage metadata']
      }
      @doc = @obj.to_solr
      expect(@doc['coverage_tesim']).to match_array(['Coverage metadata'])
    end
  end

  describe 'apc' do
    it 'has apc' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        apc: ['Article processing charge is 12.78']
      }
      @obj.save!
      @obj.reload
      expect(@obj.apc).to be_kind_of ActiveTriples::Relation
      expect(@obj.apc).to eq ['Article processing charge is 12.78']
    end

    it 'indexes the apc' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        apc: ['12.78']
      }
      @doc = @obj.to_solr
      expect(@doc['apc_tesim']).to match_array(['12.78'])
    end
  end

  describe 'version' do
    it 'has version' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        version: ['1.0']
      }
      @obj.save!
      @obj.reload
      expect(@obj.version).to be_kind_of ActiveTriples::Relation
      expect(@obj.version).to eq ['1.0']
    end

    it 'indexes the version' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        version: ['1.0']
      }
      @doc = @obj.to_solr
      expect(@doc['version_tesim']).to match_array(['1.0'])
      expect(@doc['version_sim']).to match_array(['1.0'])
    end
  end

  describe 'nested attributes for date' do
    it 'accepts date attributes' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        date_attributes: [{
            date: '2017-01-01',
            description: 'Date definition'
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.date.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.date.first.id).to include('#date')
      expect(@obj.date.first.date).to eq ['2017-01-01']
      expect(@obj.date.first.description).to eq ['Date definition']
    end

    it 'rejects date attributes if date is blank' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        date_attributes: [{
            date: '2017-01-01',
            description: 'date definition'
          }, {
            description: 'Date definition'
          }, {
            date: '2018-01-01'
          }, {
            date: ''
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.date.size).to eq(2)
    end

    it 'destroys date' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        date_attributes: [{
          date: '2017-01-01',
          description: 'date definition'
        }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.date.size).to eq(1)
      @obj.attributes = {
        date_attributes: [{
          id: @obj.date.first.id,
          date: '2017-01-01',
          description: 'date definition',
          _destroy: "1"
        }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.date.size).to eq(0)
    end

    it 'indexes the date' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        date_attributes: [{
          date: '2017-01-01',
          description: 'http://purl.org/dc/terms/dateAccepted',
        }, {
          date: '2018-01-01'
        }]
      }
      @doc = @obj.to_solr
      expect(@doc).to include('date_ssm')
      expect(@doc['date_tesim']).to match_array(['2017-01-01', '2018-01-01'])
      expect(@doc['date_accepted_ssi']).to match_array(['2017-01-01'])
    end
  end

  describe 'nested attributes for creator' do
    it 'accepts person attributes' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        creator_nested_attributes: [{
            first_name: 'Foo',
            last_name: 'Bar',
            orcid: '0000-0000-0000-0000',
            affiliation: 'Author affiliation',
            role: 'Author'
          },
          {
            last_name: 'Hello world',
            orcid: '0001-0001-0001-0001',
            role: 'Author'
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.creator_nested.size).to eq(2)
      expect(@obj.creator_nested[0]).to be_kind_of ActiveTriples::Resource
      expect(@obj.creator_nested[0].id).to include('#person')
      expect(@obj.creator_nested[1]).to be_kind_of ActiveTriples::Resource
      expect(@obj.creator_nested[1].id).to include('#person')
    end

    it 'rejects person if first name and last name are blank' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        creator_nested_attributes: [
          {
            first_name: 'Foo',
            orcid: '0000-0000-0000-0000',
            role: 'Author'
          },
          {
            last_name: 'Bar',
            orcid: '0000-0000-0000-0000',
            role: 'Author'
          },
          {
            first_name: '',
            last_name: nil,
            orcid: '0000-0000-0000-0000',
            role: 'Author'
          },
          {
            orcid: '0000-0000-0000-0000',
            role: 'Author'
          }
        ]
      }
      @obj.save!
      @obj.reload
      expect(@obj.creator_nested.size).to eq(2)
    end

    it 'rejects person if orcid is blank' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        creator_nested_attributes: [
          {
            first_name: 'Foo',
            last_name: 'Bar',
            role: 'Author'
          },
          {
            first_name: 'Foo',
            last_name: 'Bar',
            orcid: '',
            role: 'Author'
          }
        ]
      }
      @obj.save!
      @obj.reload
      expect(@obj.creator_nested.size).to eq(0)
    end

    it 'rejects person if role is blank' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        creator_nested_attributes: [
          {
            first_name: 'Foo',
            last_name: 'Bar',
            orcid: '0000-0000-0000-0000'
          },
          {
            first_name: 'Foo',
            last_name: 'Bar',
            orcid: '0000-0000-0000-0000',
            affiliation: 'Author affiliation',
            role: nil
          }
        ]
      }
      @obj.save!
      @obj.reload
      expect(@obj.creator_nested.size).to eq(0)
    end

    it 'rejects person if all are blank' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        creator_nested_attributes: [
          {
            first_name: '',
            last_name: nil,
            role: nil
          }
        ]
      }
      @obj.save!
      @obj.reload
      expect(@obj.creator_nested.size).to eq(0)
    end

    it 'destroys creator' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        creator_nested_attributes: [{
            first_name: 'Foo',
            last_name: 'Bar',
            orcid: '0000-0000-0000-0000',
            affiliation: 'Author affiliation',
            role: 'Author'
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.creator_nested.size).to eq(1)
      @obj.attributes = {
        creator_nested_attributes: [{
            id: @obj.creator_nested.first.id,
            first_name: 'Foo',
            last_name: 'Bar',
            orcid: '0000-0000-0000-0000',
            affiliation: 'Author affiliation',
            role: 'Author',
            _destroy: "1"
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.creator_nested.size).to eq(0)
    end

    it 'indexes the creator' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        creator_nested_attributes: [{
            first_name: ['Foo'],
            last_name: 'Bar',
            orcid: '0000-0000-0000-0000',
            role: 'Author'
          }, {
            last_name: 'Bar',
            orcid: '0000-0000-0000-0000',
            role: 'Author'
          }]
      }
      @doc = @obj.to_solr
      expect(@doc['creator_nested_sim']).to match_array(['Foo Bar', 'Bar'])
      expect(@doc['creator_nested_tesim']).to match_array(['Foo Bar', 'Bar'])
      expect(@doc).to include('creator_nested_ssm')
    end
  end

  describe 'nested attributes for rights' do
    it 'accepts rights attributes' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        rights_nested_attributes: [{
            label: 'A rights label',
            definition: 'A definition of the rights',
            webpage: 'http://example.com/rights'
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.rights_nested.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.rights_nested.first.id).to include('#rights')
      expect(@obj.rights_nested.first.label).to eq ['A rights label']
      expect(@obj.rights_nested.first.definition).to eq ['A definition of the rights']
      expect(@obj.rights_nested.first.webpage).to eq ['http://example.com/rights']
    end

    it 'rejects rights attributes if any attribute is blank' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        rights_nested_attributes: [{
            label: 'A rights label'
          }, {
            definition: 'A definition of the rights'
          }, {
            webpage: 'http://example.com/rights'
          }, {
            label: '',
            definition: nil,
            webpage: ''
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.rights_nested.size).to eq(3)
    end

    it 'destroys rights' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        rights_nested_attributes: [{
            label: 'test label'
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.rights_nested.size).to eq(1)
      @obj.attributes = {
        rights_nested_attributes: [{
            id: @obj.rights_nested.first.id,
            label: 'test label',
            _destroy: "1"
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.rights_nested.size).to eq(0)
    end

    it 'indexes the rights' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        rights_nested_attributes: [{
            label: 'A rights label',
            definition: 'A definition of the rights',
            webpage: 'http://example.com/rights'
          }, {
            label: 'A 2nd rights label',
            webpage: 'http://example.com/rights_2nd'
          }]
      }
      @doc = @obj.to_solr
      expect(@doc['rights_nested_sim']).to match_array(
        ['http://example.com/rights', 'http://example.com/rights_2nd'])
      expect(@doc).to include('rights_nested_tesim')
    end
  end

  describe 'nested attributes for subject' do
    it 'accepts subject attributes' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        subject_nested_attributes: [{
            label: 'Subject label',
            definition: 'Subject label definition',
            classification: 'LCSH',
            homepage: 'http://example.com/homepage'
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.subject_nested.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.subject_nested.first.id).to include('#subject')
      expect(@obj.subject_nested.first.label).to eq ['Subject label']
      expect(@obj.subject_nested.first.definition).to eq ['Subject label definition']
      expect(@obj.subject_nested.first.classification).to eq ['LCSH']
      expect(@obj.subject_nested.first.homepage).to eq ['http://example.com/homepage']
    end

    it 'rejects subject attributes if label is blank' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        subject_nested_attributes: [{
            label: 'Subject label',
            definition: 'Subject label definition',
            classification: 'LCSH',
            homepage: 'http://example.com/homepage'
          }, {
            definition: 'Subject label definition',
            classification: 'LCSH',
            homepage: 'http://example.com/homepage'
          }, {
            label: ''
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.subject_nested.size).to eq(1)
    end

    it 'destroys subject' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        subject_nested_attributes: [{
          label: 'Subject label',
          definition: 'Subject label definition',
          classification: 'LCSH',
          homepage: 'http://example.com/homepage'
        }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.subject_nested.size).to eq(1)
      @obj.attributes = {
        subject_nested_attributes: [{
          id: @obj.subject_nested.first.id,
          label: 'Subject label',
          definition: 'Subject label definition',
          classification: 'LCSH',
          homepage: 'http://example.com/homepage',
          _destroy: "1"
        }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.subject_nested.size).to eq(0)
    end

    it 'indexes the subject' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        subject_nested_attributes: [{
          label: 'Subject label',
          definition: 'Subject label definition',
          classification: 'LCSH',
          homepage: 'http://example.com/homepage'
        }, {
          label: 'Subject label 2',
        }]
      }
      @doc = @obj.to_solr
      expect(@doc).to include('subject_nested_tesim')
      expect(@doc).to include('subject_nested_sim')
      expect(@doc['subject_nested_tesim']).to match_array(['Subject label', 'Subject label 2'])
      expect(@doc['subject_nested_sim']).to match_array(['Subject label', 'Subject label 2'])
    end
  end

  describe 'nested attributes for relation' do
    it 'accepts relation attributes' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test title'],
        relation_attributes: [
          {
            label: 'A relation label',
            url: 'http://example.com/relation',
            identifier: '123456',
            identifier_scheme: 'local',
            relationship_name: 'Is part of',
            relationship_role: 'http://example.com/isPartOf'
          }
        ]
      }
      @obj.save!
      @obj.reload
      expect(@obj.relation.size).to eq 1
      expect(@obj.relation.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.relation.first.id).to include('#relation')
      expect(@obj.relation.first.label).to eq ['A relation label']
      expect(@obj.relation.first.url).to eq ['http://example.com/relation']
      expect(@obj.relation.first.identifier).to eq ['123456']
      expect(@obj.relation.first.identifier_scheme).to eq ['local']
      expect(@obj.relation.first.relationship_name).to eq ['Is part of']
      expect(@obj.relation.first.relationship_role).to eq ['http://example.com/isPartOf']
    end

    it 'rejects relation if label is blank' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test title'],
        relation_attributes: [{
          label: 'Test label',
          url: 'http://example.com/url',
          identifier: '123456',
          relationship_name: 'Is part of',
          relationship_role: 'http://example.com/isPartOf'
        }, {
          label: '',
          url: 'http://example.com/url',
          identifier: '123456',
          relationship_name: 'Is part of',
          relationship_role: 'http://example.com/isPartOf'
        }, {
          url: 'http://example.com/url',
          identifier: '123456',
          relationship_name: 'Is part of',
          relationship_role: 'http://example.com/isPartOf'
        }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.relation.size).to eq(1)
    end

    it 'rejects relation if url or identifier is blank' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test title'],
        relation_attributes: [{
          label: 'Test label',
          url: 'http://example.com/url',
          identifier: '123456',
          relationship_name: 'Is part of',
          relationship_role: 'http://example.com/isPartOf'
        }, {
          label: 'Test label',
          identifier: '123456',
          relationship_name: 'Is part of',
          relationship_role: 'http://example.com/isPartOf'
        }, {
          label: 'Test label',
          url: 'http://example.com/url',
          relationship_name: 'Is part of',
          relationship_role: 'http://example.com/isPartOf'
        }, {
          label: 'Test label',
          url: '',
          identifier: nil,
          relationship_name: 'Is part of',
          relationship_role: 'http://example.com/isPartOf'
        }, {
          label: 'Test label',
          relationship_name: 'Is part of',
          relationship_role: 'http://example.com/isPartOf'
        }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.relation.size).to eq(3)
    end

    it 'rejects relation if relationship role or relationship name blank' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test title'],
        relation_attributes: [{
          label: 'Test label',
          url: 'http://example.com/url',
          identifier: '123456',
          relationship_name: 'Is part of',
          relationship_role: 'http://example.com/isPartOf'
        }, {
          label: 'Test label',
          url: 'http://example.com/url',
          identifier: '123456',
          relationship_name: 'Is part of'
        }, {
          label: 'Test label',
          url: 'http://example.com/url',
          identifier: '123456',
          relationship_role: 'http://example.com/isPartOf'
        }, {
          label: 'Test label',
          url: 'http://example.com/url',
          identifier: '123456',
          relationship_name: '',
          relationship_role: nil
        }, {
          label: 'Test label',
          url: 'http://example.com/url',
          identifier: '123456',
        }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.relation.size).to eq(3)
    end

    it 'destroys relation' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test title'],
        relation_attributes: [{
          label: 'test label',
          url: 'http://example.com/relation',
          relationship_name: 'Is part of'
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.relation.size).to eq(1)
      @obj.attributes = {
        relation_attributes: [{
          id: @obj.relation.first.id,
          label: 'test label',
          url: 'http://example.com/relation',
          relationship_name: 'Is part of',
          _destroy: "1"
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.relation.size).to eq(0)
    end

    it 'indexes relation' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        relation_attributes: [{
          label: 'test label',
          url: 'http://example.com/relation',
          identifier: '123456',
          relationship_name: 'Is part of'
        }, {
          label: 'test label 2',
          url: 'http://example.com/relation2',
          relationship_role: 'http://example.com/isPartOf'
        }]
      }
      @doc = @obj.to_solr
      expect(@doc).to include('relation_ssm')
      expect(@doc['relation_url_sim']).to match_array(
        ['http://example.com/relation', 'http://example.com/relation2'])
      expect(@doc['relation_id_sim']).to eq ['123456']
    end
  end

  describe 'nested attributes for admin_metadata' do
    it 'accepts admin_metadata attributes' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test title'],
        admin_metadata_attributes: [{
          question: 'An admin question needing an answer',
          response: 'Response to admin question'
        }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.admin_metadata.size).to eq(1)
      expect(@obj.admin_metadata.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.admin_metadata.first.id).to include('#admin_metadata')
      expect(@obj.admin_metadata.first.question).to eq ['An admin question needing an answer']
      expect(@obj.admin_metadata.first.response).to eq ['Response to admin question']
    end

    it 'rejects attributes if question blank' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test title'],
        admin_metadata_attributes: [
          {
            question: 'An admin question needing an answer'
          },
          {
            response: 'a response'
          },
          {
            question: '',
            response: nil
          }
        ]
      }
      @obj.save!
      @obj.reload
      expect(@obj.admin_metadata.size).to eq(1)
    end

    it 'destroys admin_metadata' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test title'],
        admin_metadata_attributes: [{
            question: 'An admin question needing an answer',
            response: 'Response to admin question'
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.admin_metadata.size).to eq(1)
      @obj.attributes = {
        admin_metadata_attributes: [{
            id: @obj.admin_metadata.first.id,
            question: 'An admin question needing an answer',
            response: 'Response to admin question',
            _destroy: "1"
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.admin_metadata.size).to eq(0)
    end
  end

  describe 'nested attributes for project' do
    it 'accepts project attributes' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        project_attributes: [{
            identifier: '123456',
            title: 'Project title',
            funder_name: 'Funder',
            funder_id: 'f34566',
            grant_number: '11111',
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.project.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.project.first.id).to include('#project')
      expect(@obj.project.first.identifier).to eq ['123456']
      expect(@obj.project.first.title).to eq ['Project title']
      expect(@obj.project.first.funder_name).to eq ['Funder']
      expect(@obj.project.first.funder_id).to eq ['f34566']
      expect(@obj.project.first.grant_number).to eq ['11111']
    end

    it 'rejects project attributes if all blank' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        project_attributes: [{
            title: 'Project title'
          }, {
            identifier: '123456'
          }, {
            funder_name: 'f34566'
          }, {
            title: ''
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.project.size).to eq(3)
    end

    it 'destroys project' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        project_attributes: [{
          identifier: '123456',
          title: 'Project title',
          funder_name: 'Funder'
        }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.project.size).to eq(1)
      @obj.attributes = {
        project_attributes: [{
          id: @obj.project.first.id,
          identifier: '123456',
          title: 'Project title',
          funder_name: 'Funder',
          _destroy: "1"
        }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.project.size).to eq(0)
    end

    it 'indexes the project' do
      @obj = Article.new
      @obj.attributes = {
        title: ['test article'],
        project_attributes: [{
          identifier: '123456',
          title: 'Project title',
          funder_name: 'Funder',
          funder_id: 'f34566',
          grant_number: '11111',
        },{
          funder_name: '2nd funder'
        }]
      }
      @doc = @obj.to_solr
      expect(@doc['project_id_ssi']).to match_array(['123456'])
      expect(@doc['project_tesim']).to match_array(['Project title'])
      expect(@doc['funder_tesim']).to match_array(['Funder', '2nd funder'])
      expect(@doc['funder_sim']).to match_array(['Funder', '2nd funder'])
      expect(@doc['funder_id_sim']).to match_array(['f34566'])
      expect(@doc['grant_number_ssi']).to match_array(['11111'])
    end
  end
end
