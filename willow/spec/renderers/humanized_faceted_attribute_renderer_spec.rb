require 'spec_helper'

RSpec.describe HumanizedFacetedAttributeRenderer do
  let(:field) { :resource_type }
  let(:value) { 'someCamelCasedValue' }
  let(:translated_value) { 'Translated Version' }
  subject { Nokogiri::HTML(described_class.new(field, value).render) }

  describe 'Humanized faceted attribute' do
    context 'when a translation exists' do
      before :each do
        I18n.backend.store_translations(
          :en, some_camel_cased_value: translated_value
        )
      end

      after :each do
        I18n.reload!
      end

      it 'uses that to humanize value' do
        expect(subject.css('a')[0].text).to eq(translated_value)
      end
    end

    context 'when there is no i18n available' do
      subject { Nokogiri::HTML(described_class.new(field, value).render) }

      it 'it renders a humanized version' do
        expect(subject.css('a')[0].text).to eq('Some Camel Cased Value')
      end

      it 'preserves the original attribute value in URI parameters' do
        query = subject.css('a')[0].attributes['href'].value
        expected = "/catalog?f%5Bresource_type_sim%5D%5B%5D=#{value}"
        expect(query).to eq(expected)
      end
    end
  end
end
