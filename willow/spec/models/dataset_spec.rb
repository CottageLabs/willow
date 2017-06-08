# Generated via
#  `rails generate curation_concerns:work Dataset`
require 'rails_helper'

RSpec.describe Dataset do
  it 'has human readable type dataset' do
    @obj = Dataset.new
    @obj.attributes = {
      title: ['test dataset'],
      doi: '0000-0000-0000-0000'
    }
    @obj.save!
    @obj.reload
    expect(@obj.human_readable_type).to eq('Dataset')
  end

  it 'requires title' do
    @obj = Dataset.new
    expect { @obj.save! }.to raise_error
      ('ActiveFedora::RecordInvalid: Validation failed: Title Your work must have a title.')
  end

  describe 'doi' do
    it 'requires doi' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset']
      }
      expect { @obj.save! }.to raise_error
        ('ActiveFedora::RecordInvalid: Validation failed: DOI Your work must have a doi.')
    end

    it 'has a single valued doi' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000'
      }
      @obj.save!
      @obj.reload
      expect(@obj.doi).to be_kind_of String
      expect(@obj.doi).to eq '0000-0000-0000-0000'
    end
  end

  it 'has publisher' do
    @obj = Dataset.new
    @obj.attributes = {
      title: ['test dataset'],
      doi: '0000-0000-0000-0000',
      publisher: ['Willow']
    }
    @obj.save!
    @obj.reload
    expect(@obj.publisher).to be_kind_of ActiveTriples::Relation
    expect(@obj.publisher).to eq ['Willow']
  end

  describe 'nested attributes for other title' do
    it 'accepts other title attributes' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
        other_title_attributes: [{
            title: 'Another title',
            title_type: 'Title type'
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.other_title.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.other_title.first.id).to include('#title')
      expect(@obj.other_title.first.title).to eq ['Another title']
      expect(@obj.other_title.first.title_type).to eq ['Title type']
    end

    it 'rejects other title attributes if title is blank' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
        other_title_attributes: [{
            title: 'Another title',
            title_type: 'Title type'
          }, {
            title: 'A third title'
          }, {
            title_type: 'Title type'
          }
        ]
      }
      @obj.save!
      @obj.reload
      expect(@obj.other_title.size).to eq(2)
    end

    it 'destroys other titles' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
        other_title_attributes: [{
          title: 'Another title',
          title_type: 'Title type'
        }]
      }
      @obj.save!
      @obj.reload
      @obj.attributes = {
        other_title_attributes: [{
          id: @obj.other_title.first.id,
          title: 'Another title',
          title_type: 'Title type',
          _destroy: "1"
        }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.other_title.size).to eq(0)
    end

    it 'indexes the other titles' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
        other_title_attributes: [{
          title: 'Another title',
          title_type: 'Title type'
        }]
      }
      @doc = @obj.to_solr
      expect(@doc).to include('other_title_tesim')
      expect(@doc['other_title_tesim']).to eq ['Another title']
    end
  end

  describe 'nested attributes for date' do
    it 'accepts date attributes' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
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
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
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
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
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
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
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

  describe 'nested attributes for rights' do
    it 'accepts rights attributes' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
        rights_attributes: [{
            label: 'A rights label',
            definition: 'A definition of the rights',
            webpage: 'http://example.com/rights'
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.rights.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.rights.first.id).to include('#rights')
      expect(@obj.rights.first.label).to eq ['A rights label']
      expect(@obj.rights.first.definition).to eq ['A definition of the rights']
      expect(@obj.rights.first.webpage).to eq ['http://example.com/rights']
    end

    it 'rejects rights attributes if all blank' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
        rights_attributes: [{
            label: '',
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.rights.size).to eq(0)
    end

    it 'destroys rights' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
        rights_attributes: [{
            label: 'test label'
          }]
      }
      @obj.save!
      @obj.reload
      @obj.attributes = {
        rights_attributes: [{
            id: @obj.rights.first.id,
            label: 'test label',
            _destroy: "1"
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.rights.size).to eq(0)
    end

    it 'indexes the rights' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
        rights_attributes: [{
            label: 'A rights label',
            definition: 'A definition of the rights',
            webpage: 'http://example.com/rights'
          }]
      }
      @doc = @obj.to_solr
      expect(@doc['rights_sim']).to eq ['http://example.com/rights']
      expect(@doc).to include('rights_tesim')
    end
  end

  describe 'nested attributes for creator' do
    it 'accepts person attributes' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
        creator_attributes: [{
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
      expect(@obj.creator.size).to eq(2)
      expect(@obj.creator[0]).to be_kind_of ActiveTriples::Resource
      expect(@obj.creator[0].id).to include('#person')
      expect(@obj.creator[1]).to be_kind_of ActiveTriples::Resource
      expect(@obj.creator[1].id).to include('#person')
    end

    it 'rejects person if first name and last name are blank' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
        creator_attributes: [
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
      expect(@obj.creator.size).to eq(2)
    end

    it 'rejects person if orcid is blank' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
        creator_attributes: [
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
      expect(@obj.creator.size).to eq(0)
    end

    it 'rejects person if role is blank' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
        creator_attributes: [
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
      expect(@obj.creator.size).to eq(0)
    end

    it 'rejects person if all are blank' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
        creator_attributes: [
          {
            first_name: '',
            last_name: nil,
            role: nil
          }
        ]
      }
      @obj.save!
      @obj.reload
      expect(@obj.creator.size).to eq(0)
    end

    it 'destroys creator' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
        creator_attributes: [{
            first_name: 'Foo',
            last_name: 'Bar',
            orcid: '0000-0000-0000-0000',
            affiliation: 'Author affiliation',
            role: 'Author'
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.creator.size).to eq(1)
      @obj.attributes = {
        creator_attributes: [{
            id: @obj.creator.first.id,
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
      expect(@obj.creator.size).to eq(0)
    end

    it 'indexes the creator' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
        creator_attributes: [{
            first_name: ['Foo'],
            last_name: 'Bar',
            orcid: '0000-0000-0000-0000',
            role: 'Author'
          }]
      }
      @doc = @obj.to_solr
      expect(@doc['creator_sim']).to eq ['Foo Bar']
      expect(@doc['creator_tesim']).to eq ['Foo Bar']
      expect(@doc).to include('creator_ssm')
    end
  end

  describe 'nested attributes for subject' do
    it 'accepts subject attributes' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
        subject_attributes: [{
            label: 'Subject label',
            definition: 'Subject label definition',
            classification: 'LCSH',
            homepage: 'http://example.com/homepage'
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.subject.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.subject.first.id).to include('#subject')
      expect(@obj.subject.first.label).to eq ['Subject label']
      expect(@obj.subject.first.definition).to eq ['Subject label definition']
      expect(@obj.subject.first.classification).to eq ['LCSH']
      expect(@obj.subject.first.homepage).to eq ['http://example.com/homepage']
    end

    it 'rejects subject attributes if label is blank' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
        subject_attributes: [{
            label: 'Subject label',
            definition: 'Subject label definition',
            classification: 'LCSH',
            homepage: 'http://example.com/homepage'
          }, {
            classification: 'LCSH',
            homepage: 'http://example.com/homepage'
          }, {
            label: ''
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.subject.size).to eq(1)
    end

    it 'destroys subject' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
        subject_attributes: [{
          label: 'Subject label',
          definition: 'Subject label definition',
          classification: 'LCSH',
          homepage: 'http://example.com/homepage'
        }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.subject.size).to eq(1)
      @obj.attributes = {
        subject_attributes: [{
          id: @obj.subject.first.id,
          label: 'Subject label',
          definition: 'Subject label definition',
          classification: 'LCSH',
          homepage: 'http://example.com/homepage',
          _destroy: "1"
        }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.subject.size).to eq(0)
    end

    it 'indexes the subject' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
        subject_attributes: [{
          label: 'Subject label',
          definition: 'Subject label definition',
          classification: 'LCSH',
          homepage: 'http://example.com/homepage'
        }, {
          label: 'Subject label 2',
        }]
      }
      @doc = @obj.to_solr
      expect(@doc).to include('subject_tesim')
      expect(@doc).to include('subject_sim')
      expect(@doc['subject_tesim']).to match_array(['Subject label', 'Subject label 2'])
      expect(@doc['subject_sim']).to match_array(['Subject label', 'Subject label 2'])
    end
  end

  describe 'nested attributes for relation' do
    it 'accepts relation attributes' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test title'],
        doi: '0000-0000-0000-0000',
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
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test title'],
        doi: '0000-0000-0000-0000',
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
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test title'],
        doi: '0000-0000-0000-0000',
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
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test title'],
        doi: '0000-0000-0000-0000',
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
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test title'],
        doi: '0000-0000-0000-0000',
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
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        doi: '0000-0000-0000-0000',
        relation_attributes: [{
          label: 'test label',
          url: 'http://example.com/relation',
          identifier: '123456',
          relationship_name: 'Is part of'
        }]
      }
      @doc = @obj.to_solr
      expect(@doc).to include('relation_ssm')
      expect(@doc['relation_url_sim']).to eq ['http://example.com/relation']
      expect(@doc['relation_id_sim']).to eq ['123456']
    end
  end

  describe 'nested attributes for admin_metadata' do
    it 'accepts admin_metadata attributes' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test title'],
        doi: '0000-0000-0000-0000',
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
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test title'],
        doi: '0000-0000-0000-0000',
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
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test title'],
        doi: '0000-0000-0000-0000',
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
end
