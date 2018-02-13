require 'spec_helper'

RSpec.describe ObjectIdentifiersAttributeRenderer do

  describe 'Object Identifiers Attribute Renderer' do
    
    def render_identifier value
      Nokogiri::HTML(described_class.new(:object_identifiers, value).render)
    end

    context 'when type is an enumeration value' do
      let(:value) do
        '{"identifier_type": "doi", "identifier_value": "12345"}'
      end

      it 'looks up and displays the label' do
        expect(render_identifier(value).css('.td')[0].text).to eq('DOI')
      end

      it 'displays the identifier value' do
        expect(render_identifier(value).css('.td')[1].text).to eq('12345')
      end
    end

    context 'when type is not an enumeration value' do
      let(:value) do
        '{"identifier_type": "notInEnum", "identifier_value": "67890"}'
      end

      it 'it displays the type as directly entered' do
        expect(render_identifier(value).css('.td')[0].text).to eq('notInEnum')
      end

      it 'displays the identifier value' do
        expect(render_identifier(value).css('.td')[1].text).to eq('67890')
      end
    end
  end
end