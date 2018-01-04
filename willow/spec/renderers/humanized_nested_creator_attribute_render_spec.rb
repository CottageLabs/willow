require 'spec_helper'

RSpec.describe HumanizedNestedCreatorAttributeRenderer do
  let(:values) do
    [
      {
        'id': 'http://fedora:8080/rest/willow_development/2v/23/vt/37/2v23vt37b#persong74340540',
        'first_name': ['Foo'],
        'last_name': ['Bar'],
        'name': ['UNKNOWN'],
        'orcid': ['UNKNOWN'],
        'role': ['author'],
        'affiliation': ['UNKNOWN'],
        'uri': [],
        'identifier': []
      }
    ]
  end

  subject { Nokogiri::HTML(described_class.new(:creator, values.to_json).render) }

  describe 'Creator Name' do
    context 'when keys include :name' do
      it 'uses that by default' do
        expect(subject.css('a')[0].text).to eq('Unknown')
      end
    end

    context 'when key :name is missing or empty' do
      before do
        values[0] = values[0].except(:name)
      end

      context 'when :first_name and :last_name present' do
        it 'concatenates both keys' do
          expect(subject.css('a')[0].text).to eq('Foo Bar')
        end
      end

      context 'when only :first_name' do
        it 'uses that value' do
          values[0] = values[0].except(:last_name)
          expect(subject.css('a')[0].text).to eq('Foo')
        end
      end

      context 'when only :last_name' do
        it 'uses that value' do
          values[0] = values[0].except(:first_name)
          expect(subject.css('a')[0].text).to eq('Bar')
        end
      end
    end

    describe 'Affiliation' do
      it 'uses a humanized version of value' do
        expect(subject.css('li')[0].text).to include('Affiliation: Unknown')
      end
    end

    describe 'Orcid' do
      it 'uses a humanized version of value' do
        expect(subject.css('li')[0].text).to include('Orcid: Unknown')
      end
    end

    describe 'Role' do
      it 'uses a humanized version of value' do
        expect(subject.css('li')[0].text).to include('Role: Author')
      end
    end
  end
end
