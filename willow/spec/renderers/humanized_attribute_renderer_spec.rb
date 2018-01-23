require 'spec_helper'

RSpec.describe HumanizedAttributeRenderer do
  let(:field) { :resource_type }
  let(:value) { 'someCamelCasedValue' }
  let(:translated_value) { 'Translated Version' }
  subject { Nokogiri::HTML(described_class.new(field, value).render) }

  describe 'Humanized  attribute' do
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
        expect(subject.css('li')[0].text).to eq(translated_value)
      end
    end

    context 'when there is no i18n available' do
      subject { Nokogiri::HTML(described_class.new(field, value).render) }

      it 'it renders a humanized version' do
        expect(subject.css('li')[0].text).to eq('Some Camel Cased Value')
      end
    end
  end
end
