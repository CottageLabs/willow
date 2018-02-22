require 'spec_helper'

RSpec.describe ObjectRelatedIdentifiersAttributeRenderer do

  describe 'Object Identifiers Attribute Renderer' do

    def render_identifier value
      Nokogiri::HTML(described_class.new(:object_identifiers, value).render)
    end

    context 'when relation type and identifier type are enumeration values' do
      let(:value) do
        '{"relation_type":"cites", "identifier": {"identifier_type": "doi", "identifier_value": "12345"}}'
      end

      it 'looks up and displays the relation type label' do
        expect(render_identifier(value).css('.td')[0].text).to eq('Cites')
      end

      it 'looks up and displays the identifier type label' do
        expect(render_identifier(value).css('.td')[1].text).to eq('DOI')
      end


      it 'displays the identifier value' do
        expect(render_identifier(value).css('.td')[2].text).to eq('12345')
      end
    end

    context 'when relation type is not an enumeration value' do
      let(:value) do
        '{"relation_type":"notInEnum", "identifier": {"identifier_type": "ark", "identifier_value": "67890"}}'
      end

      it 'it displays the relatio type as directly entered' do
        expect(render_identifier(value).css('.td')[0].text).to eq('notInEnum')
      end

      it 'looks up and displays the identifier type label' do
        expect(render_identifier(value).css('.td')[1].text).to eq('ARK')
      end

      it 'displays the identifier value' do
        expect(render_identifier(value).css('.td')[2].text).to eq('67890')
      end
    end

    context 'when indentifier type is not an enumeration value' do
      let(:value) do
        '{"relation_type":"is_part_of", "identifier": {"identifier_type": "notInEnum", "identifier_value": "98765"}}'
      end

      it 'it displays the relatio type as directly entered' do
        expect(render_identifier(value).css('.td')[0].text).to eq('Is Part Of')
      end

      it 'looks up and displays the identifier type label' do
        expect(render_identifier(value).css('.td')[1].text).to eq('notInEnum')
      end

      it 'displays the identifier value' do
        expect(render_identifier(value).css('.td')[2].text).to eq('98765')
      end
    end
  end
end
