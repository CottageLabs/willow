# Generated via
#  `rails generate hyrax:work RdssDataset`
require 'rails_helper'

RSpec.describe RdssDataset do
  it 'has human readable type rdss_dataset' do
    @obj = build(:rdss_dataset)
    expect(@obj.human_readable_type).to eq('RDSS Dataset')
  end

  describe 'title' do
    it 'requires title' do
      @obj = build(:rdss_dataset, title: nil)
      #@obj.save!
      expect{@obj.save!}.to raise_error(ActiveFedora::RecordInvalid, 'Validation failed: Title Your dataset must have a title.')
    end

    it 'has a multi valued title field' do
      @obj = build(:rdss_dataset, title: ['test rdss_dataset'])
      expect(@obj.title).to eq ['test rdss_dataset']
    end
  end

  describe 'rating' do
    it 'has a rating' do
      @obj = build(:rdss_dataset, rating: ['Normal'])
      expect(@obj.rating).to be_kind_of ActiveTriples::Relation
      expect(@obj.rating).to eq ['Normal']
    end

    it 'indexes rating' do
      @obj = build(:rdss_dataset, rating: ['Normal'])
      @doc = @obj.to_solr
      expect(@doc['rating_sim']).to eq ['Normal']
      expect(@doc['rating_tesim']).to eq ['Normal']
    end
  end

  describe 'category' do
    it 'has a category' do
      @obj = build(:rdss_dataset, category: ['Category'])
      expect(@obj.category).to be_kind_of ActiveTriples::Relation
      expect(@obj.category).to eq ['Category']
    end

    it 'indexes category' do
      @obj = build(:rdss_dataset, category: ['Category'])
      @doc = @obj.to_solr
      expect(@doc['category_sim']).to eq ['Category']
      expect(@doc['category_tesim']).to eq ['Category']
    end
  end

  describe 'rights holder' do
    it 'has a rights_holder' do
      @obj = build(:rdss_dataset, rights_holder: ['Willow'])
      expect(@obj.rights_holder).to be_kind_of ActiveTriples::Relation
      expect(@obj.rights_holder).to eq ['Willow']
    end

    it 'indexes rights_holder' do
      @obj = build(:rdss_dataset, rights_holder: ['Willow'])
      @doc = @obj.to_solr
      expect(@doc['rights_holder_sim']).to eq ['Willow']
      expect(@doc['rights_holder_tesim']).to eq ['Willow']
    end
  end

  describe 'nested attributes for date' do
    it 'accepts date attributes' do
      @obj = build(:rdss_dataset, date_attributes: [{
            date: '2017-01-01',
            description: 'Date definition'
          }]
      )
      expect(@obj.date.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.date.first.date).to eq ['2017-01-01']
      expect(@obj.date.first.description).to eq ['Date definition']
    end

    it 'has the correct uri' do
      @obj = build(:rdss_dataset, date_attributes: [{
            date: '2017-01-01',
            description: 'Date definition'
          }]
      )
      expect(@obj.date.first.id).to include('#date')
    end

    it 'rejects date attributes if date is blank' do
      @obj = build(:rdss_dataset, date_attributes: [{
            date: '2017-01-01',
            description: 'date definition'
          }, {
            description: 'Date definition'
          }, {
            date: '2018-01-01'
          }, {
            date: ''
          }]
      )
      expect(@obj.date.size).to eq(2)
    end

    it 'destroys date' do
      @obj = build(:rdss_dataset, date_attributes: [{
          date: '2017-01-01',
          description: 'date definition'
        }]
      )
      expect(@obj.date.size).to eq(1)
      @obj.attributes = {
        date_attributes: [{
          id: @obj.date.first.id,
          date: '2017-01-01',
          description: 'date definition',
          _destroy: "1"
        }]
      }
      expect(@obj.date.size).to eq(0)
    end

    it 'indexes the date' do
      @obj = build(:rdss_dataset, date_attributes: [{
          date: '2017-01-01',
          description: 'http://purl.org/dc/terms/dateAccepted',
        }, {
          date: '2018-01-01'
        }]
      )
      @doc = @obj.to_solr
      expect(@doc).to include('date_ssm')
      expect(@doc['date_tesim']).to match_array(['2017-01-01', '2018-01-01'])
      expect(@doc['date_accepted_ssi']).to match_array(['2017-01-01'])
    end
  end

  describe 'nested attributes for rights' do
    it 'accepts rights attributes' do
      @obj = build(:rdss_dataset, license_nested_attributes: [{
            label: 'A rights label',
            definition: 'A definition of the rights',
            webpage: 'http://example.com/rights'
          }]
      )
      expect(@obj.license_nested.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.license_nested.first.label).to eq ['A rights label']
      expect(@obj.license_nested.first.definition).to eq ['A definition of the rights']
      expect(@obj.license_nested.first.webpage).to eq ['http://example.com/rights']
    end

    it 'has the correct uri' do
      @obj = build(:rdss_dataset, license_nested_attributes: [{
            label: 'A rights label',
            definition: 'A definition of the rights',
            webpage: 'http://example.com/rights'
          }]
      )
      expect(@obj.license_nested.first.id).to include('#rights')
    end

    it 'rejects rights attributes if all blank' do
      @obj = build(:rdss_dataset, license_nested_attributes: [{ label: '' }] )
      expect(@obj.license_nested.size).to eq(0)
    end

    it 'destroys rights' do
      @obj = build(:rdss_dataset, license_nested_attributes: [{ label: 'test label' }] )
      expect(@obj.license_nested.size).to eq(1)
      @obj.attributes = {
        license_nested_attributes: [{
            id: @obj.license_nested.first.id,
            label: 'test label',
            _destroy: "1"
          }]
      }
      expect(@obj.license_nested.size).to eq(0)
    end

    it 'indexes the rights' do
      @obj = build(:rdss_dataset, license_nested_attributes: [{
            label: 'A rights label',
            definition: 'A definition of the rights',
            webpage: 'http://example.com/rights'
          }]
      )
      @doc = @obj.to_solr
      expect(@doc['license_nested_sim']).to eq ['http://example.com/rights']
      expect(@doc).to include('license_nested_tesim')
    end
  end

  describe 'nested attributes for relation' do
    it 'accepts relation attributes' do
      @obj = build(:rdss_dataset, relation_attributes: [
          {
            label: 'A relation label',
            url: 'http://example.com/relation',
            identifier: '123456',
            identifier_scheme: 'local',
            relationship_name: 'Is part of',
            relationship_role: 'http://example.com/isPartOf'
          }
        ]
      )
      expect(@obj.relation.size).to eq 1
      expect(@obj.relation.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.relation.first.label).to eq ['A relation label']
      expect(@obj.relation.first.url).to eq ['http://example.com/relation']
      expect(@obj.relation.first.identifier).to eq ['123456']
      expect(@obj.relation.first.identifier_scheme).to eq ['local']
      expect(@obj.relation.first.relationship_name).to eq ['Is part of']
      expect(@obj.relation.first.relationship_role).to eq ['http://example.com/isPartOf']
    end

    it 'has the correct uri' do
      @obj = build(:rdss_dataset, relation_attributes: [
          {
            label: 'A relation label',
            url: 'http://example.com/relation',
            identifier: '123456',
            identifier_scheme: 'local',
            relationship_name: 'Is part of',
            relationship_role: 'http://example.com/isPartOf'
          }
        ]
      )
      expect(@obj.relation.first.id).to include('#relation')
    end

    it 'rejects relation if label is blank' do
      @obj = build(:rdss_dataset, relation_attributes: [{
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
      )
      expect(@obj.relation.size).to eq(1)
    end

    it 'rejects relation if url or identifier is blank' do
      @obj = build(:rdss_dataset, relation_attributes: [{
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
      )
      expect(@obj.relation.size).to eq(3)
    end

    it 'rejects relation if relationship role or relationship name blank' do
      @obj = build(:rdss_dataset, relation_attributes: [{
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
      )
      expect(@obj.relation.size).to eq(3)
    end

    it 'destroys relation' do
      @obj = build(:rdss_dataset, relation_attributes: [{
          label: 'test label',
          url: 'http://example.com/relation',
          relationship_name: 'Is part of'
          }]
      )
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
      expect(@obj.relation.size).to eq(0)
    end

    it 'indexes relation' do
      @obj = build(:rdss_dataset, relation_attributes: [{
          label: 'test label',
          url: 'http://example.com/relation',
          identifier: '123456',
          relationship_name: 'Is part of'
        }]
      )
      @doc = @obj.to_solr
      expect(@doc).to include('relation_ssm')
      expect(@doc['relation_url_sim']).to eq ['http://example.com/relation']
      expect(@doc['relation_id_sim']).to eq ['123456']
    end
  end

  describe 'nested attributes for identifier_object' do
    it 'accepts identifier object attributes' do
      @obj = build(:rdss_dataset, identifier_nested_attributes: [{
          obj_id_scheme: 'ISBN',
          obj_id: '123456'
        }]
      )
      expect(@obj.identifier_nested.size).to eq(1)
      expect(@obj.identifier_nested.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.identifier_nested.first.obj_id_scheme).to eq ['ISBN']
      expect(@obj.identifier_nested.first.obj_id).to eq ['123456']
    end

    it 'has the correct uri' do
      @obj = build(:rdss_dataset, identifier_nested_attributes: [{
          obj_id_scheme: 'ISBN',
          obj_id: '123456'
        }]
      )
      expect(@obj.identifier_nested.first.id).to include('#identifier')
    end

    it 'rejects attributes if id or scheme are blank' do
      @obj = build(:rdss_dataset, identifier_nested_attributes: [
          {
            obj_id_scheme: 'ISBN'
          },
          {
            obj_id: '123456'
          },
          {
            obj_id_scheme: '',
            obj_id: nil
          },
          {
            obj_id_scheme: 'ISBN',
            obj_id: '123456'
          }]
      )
      expect(@obj.identifier_nested.size).to eq(1)
    end

    it 'destroys identifier object' do
      @obj = build(:rdss_dataset, identifier_nested_attributes: [{
            obj_id_scheme: 'ISBN',
            obj_id: '123456'
          }]
      )
      expect(@obj.identifier_nested.size).to eq(1)
      @obj.attributes = {
        identifier_nested_attributes: [{
            id: @obj.identifier_nested.first.id,
            obj_id_scheme: 'ISBN',
            obj_id: '123456',
            _destroy: "1"
          }]
      }
      expect(@obj.identifier_nested.size).to eq(0)
    end

    it 'indexes the identifier object' do
      @obj = build(:rdss_dataset, identifier_nested_attributes: [{
            obj_id_scheme: 'ISBN',
            obj_id: '123456'
        }, {
            obj_id_scheme: 'ISSN',
            obj_id: '1dfsdfsd56'
        }]
      )
      @doc = @obj.to_solr
      expect(@doc).to include('identifier_nested_ssim')
      expect(@doc).to include('identifier_nested_ssm')
      expect(@doc['identifier_isbn_ssim']).to match_array(['123456'])
      expect(@doc['identifier_issn_ssim']).to match_array(['1dfsdfsd56'])
    end
  end

  describe 'nested attributes for creator' do
    it 'accepts person attributes' do
      @obj = build(:rdss_dataset,  creator_nested_attributes: [{
            first_name: 'Foo',
            last_name: 'Bar',
            name: 'Foo Bar',
            orcid: '0000-0000-0000-0000',
            affiliation: 'Author affiliation',
            role: 'Author'
          },
          {
            name: 'Hello world',
            orcid: '0001-0001-0001-0001',
            role: 'Author'
          }]
      )
      expect(@obj.creator_nested.size).to eq(2)
      expect(@obj.creator_nested[0]).to be_kind_of ActiveTriples::Resource
      expect(@obj.creator_nested[1]).to be_kind_of ActiveTriples::Resource
    end

    it 'has the correct uri' do
      @obj = build(:rdss_dataset,  creator_nested_attributes: [{
            first_name: 'Foo',
            last_name: 'Bar',
            name: 'Foo Bar',
            orcid: '0000-0000-0000-0000',
            affiliation: 'Author affiliation',
            role: 'Author'
          }]
      )
      expect(@obj.creator_nested.first.id).to include('#person')
    end

    it 'rejects person if name, role and orcid are blank' do
      @obj = build(:rdss_dataset, creator_nested_attributes: [
          {
            first_name: 'Foo',
            orcid: '0000-0000-0000-0000',
            role: 'Author'
          },
          {
            name: 'Foo Bar',
            orcid: '',
            role: 'Author'
          },
          {
            name: 'Foo Bar',
            orcid: '0000-0000-0000-0000',
            role: nil
          },
          {
            name: 'Foo Bar',
            orcid: '0000-0000-0000-0000',
            role: 'Author'
          }
        ]
      )
      expect(@obj.creator_nested.size).to eq(1)
    end

    it 'destroys creator' do
      @obj = build(:rdss_dataset, creator_nested_attributes: [{
            name: 'Foo Bar',
            orcid: '0000-0000-0000-0000',
            affiliation: 'Author affiliation',
            role: 'Author'
          }]
      )
      expect(@obj.creator_nested.size).to eq(1)
      @obj.attributes = {
        creator_nested_attributes: [{
            id: @obj.creator_nested.first.id,
            name: 'Foo Bar',
            orcid: '0000-0000-0000-0000',
            affiliation: 'Author affiliation',
            role: 'Author',
            _destroy: "1"
          }]
      }
      expect(@obj.creator_nested.size).to eq(0)
    end

    it 'indexes the creator' do
      @obj = build(:rdss_dataset, creator_nested_attributes: [{
            name: ['Foo Bar'],
            orcid: '0000-0000-0000-0000',
            role: 'Author',
            affiliation: 'Author affiliation',
          },{
            name: ['Boo Far'],
            orcid: '0000-0000-0000-1111',
            role: 'Author',
            affiliation: 'Author affiliation',
          }]
      )
      @doc = @obj.to_solr
      expect(@doc['creator_nested_sim']).to match_array(['Foo Bar', 'Boo Far'])
      expect(@doc['creator_nested_tesim']).to match_array(['Foo Bar', 'Boo Far'])
      expect(@doc).to include('creator_nested_ssm')
      expect(@doc['author_sim']).to match_array(['Foo Bar', 'Boo Far'])
      expect(@doc['author_tesim']).to match_array(['Foo Bar', 'Boo Far'])
      expect(@doc['orcid_ssim']).to match_array(['0000-0000-0000-0000', '0000-0000-0000-1111'])
    end
  end

  describe 'nested attributes for organisation' do
    it 'accepts organisation attributes' do
      @obj = build(:rdss_dataset,  organisation_nested_attributes: [{
            name: 'Foo Bar',
            role: 'Funder'
          },
          {
            name: 'Foo Bar',
            role: 'Editor',
            identifier: '1234567',
            uri: 'http://localhost/organisation/1234567'
          }]
      )
      expect(@obj.organisation_nested.size).to eq(2)
      expect(@obj.organisation_nested[0]).to be_kind_of ActiveTriples::Resource
      expect(@obj.organisation_nested[1]).to be_kind_of ActiveTriples::Resource
    end

    it 'has the correct uri' do
      @obj = build(:rdss_dataset,  organisation_nested_attributes: [{
          name: 'Foo Bar',
          role: 'Editor',
          identifier: '1234567',
          uri: 'http://localhost/organisation/1234567'
        }]
      )
      expect(@obj.organisation_nested.first.id).to include('#organisation')
    end

    it 'rejects organisation if name and role are blank' do
      @obj = build(:rdss_dataset, organisation_nested_attributes: [
          {
            name: 'Foo Bar',
            role: 'Baz'
          },
          {
            name: 'Foo Bar',
          },
          {
            name: '',
            role: 'Baz'
          },
          {
            name: 'Foo Bar',
            role: nil
          }
        ]
      )
      expect(@obj.organisation_nested.size).to eq(1)
    end

    it 'destroys organisation' do
      @obj = build(:rdss_dataset, organisation_nested_attributes: [{
          name: 'Foo Bar',
          role: 'Editor',
          identifier: '1234567',
          uri: 'http://localhost/organisation/1234567'
        }]
      )
      expect(@obj.organisation_nested.size).to eq(1)
      @obj.attributes = {
        organisation_nested_attributes: [{
          id:  @obj.organisation_nested.first.id,
          name: 'Foo Bar',
          role: 'Editor',
          identifier: '1234567',
          uri: 'http://localhost/organisation/1234567',
          _destroy: "1"
        }]
      }
      expect(@obj.organisation_nested.size).to eq(0)
    end

    it 'indexes the organisation' do
      @obj = build(:rdss_dataset, organisation_nested_attributes: [{
          name: 'Foo Bar',
          role: 'Baz',
          identifier: '1234567',
          uri: 'http://localhost/organisation/1234567'
        },{
          name: ['Boo Far'],
          role: 'Baz',
          identifier: 'Org34245234',
      }]
      )
      @doc = @obj.to_solr
      expect(@doc['organisation_nested_sim']).to match_array(['Foo Bar', 'Boo Far'])
      expect(@doc['organisation_nested_tesim']).to match_array(['Foo Bar', 'Boo Far'])
      expect(@doc).to include('organisation_nested_ssm')
      expect(@doc['baz_sim']).to match_array(['Foo Bar', 'Boo Far'])
      expect(@doc['baz_tesim']).to match_array(['Foo Bar', 'Boo Far'])
    end
  end

  describe 'nested attributes for preservation' do
    it 'accepts preservation attributes' do
      @obj = build(:rdss_dataset,  preservation_nested_attributes: [{
          name: 'Foo Bar',
          event_type: 'Baz',
          date: '2017-04-01 10:23:45',
          description: 'Event description',
          outcome: 'Success'
        },
        {
          name: 'Boo Far',
          event_type: 'Faz',
        }]
      )
      expect(@obj.preservation_nested.size).to eq(2)
      expect(@obj.preservation_nested[0]).to be_kind_of ActiveTriples::Resource
      expect(@obj.preservation_nested[1]).to be_kind_of ActiveTriples::Resource
    end

    it 'has the correct uri' do
      @obj = build(:rdss_dataset,  preservation_nested_attributes: [{
          name: 'Foo Bar',
          event_type: 'Baz',
          date: '2017-04-01 10:23:45',
          description: 'Event description',
          outcome: 'Success'
        }]
      )
      expect(@obj.preservation_nested.first.id).to include('#preservation')
    end

    it 'rejects preservation if all are blank' do
      @obj = build(:rdss_dataset, preservation_nested_attributes: [
          {
            name: 'Foo Bar',
            event_type: 'Baz',
            date: '2017-04-01 10:23:45',
            description: 'Event description',
            outcome: 'Success'
          },
          {
            name: 'Foo Bar',
          },
          {
            name: '',
          },
          {
            name: nil,
          }
        ]
      )
      expect(@obj.preservation_nested.size).to eq(2)
    end

    it 'destroys preservation' do
      @obj = build(:rdss_dataset, preservation_nested_attributes: [{
          name: 'Foo Bar',
          event_type: 'Baz',
          date: '2017-04-01 10:23:45',
          description: 'Event description',
          outcome: 'Success'
        }]
      )
      expect(@obj.preservation_nested.size).to eq(1)
      @obj.attributes = {
        preservation_nested_attributes: [{
          id:  @obj.preservation_nested.first.id,
          name: 'Foo Bar',
          event_type: 'Baz',
          date: '2017-04-01 10:23:45',
          description: 'Event description',
          outcome: 'Success',
          _destroy: "1"
        }]
      }
      expect(@obj.preservation_nested.size).to eq(0)
    end

    it 'indexes the preservation' do
      @obj = build(:rdss_dataset, preservation_nested_attributes: [{
          name: 'Foo Bar',
          event_type: 'Baz',
          date: '2017-04-01 10:23:45',
          description: 'Event description',
          outcome: 'Success'
        },{
          name: ['Boo Far']
      }]
      )
      @doc = @obj.to_solr
      expect(@doc['preservation_nested_sim']).to match_array(['Foo Bar', 'Boo Far'])
      expect(@doc['preservation_nested_tesim']).to match_array(['Foo Bar', 'Boo Far'])
      expect(@doc).to include('preservation_nested_ssm')
    end
  end

  describe 'associated with person role' do
    it "have many person roles" do
      t = RdssDataset.reflect_on_association(:person_roles)
      expect(t.macro).to eq(:has_many)
    end
  end

  describe 'associated with organisation role' do
    it "have many organisation roles" do
      t = RdssDataset.reflect_on_association(:organisation_roles)
      expect(t.macro).to eq(:has_many)
    end
  end

end
