require 'spec_helper'

RSpec.describe ObjectRightsAccessesAttributeRenderer do

  describe 'Object Rights Accesses Attribute Renderer' do
    
    def render_access value
      Nokogiri::HTML(described_class.new(:object_rights_accesses, value).render)
    end

    context 'when type is an enumeration value' do
      let(:value) do
        '{"access_type": "safeguarded", "access_statement": "Statement 1"}'
      end

      it 'looks up and displays the label' do
        expect(render_access(value).css('.td')[0].text).to eq('Safeguarded')
      end

      it 'displays the access statement' do
        expect(render_access(value).css('.td')[1].text).to eq('Statement 1')
      end
    end

    context 'when type is not an enumeration value' do
      let(:value) do
        '{"access_type": "notInEnum", "access_statement": "Statement 2"}'
      end

      it 'it displays the type as directly entered' do
        expect(render_access(value).css('.td')[0].text).to eq('notInEnum')
      end

      it 'displays the access statement' do
        expect(render_access(value).css('.td')[1].text).to eq('Statement 2')
      end
    end
  end
end