class SignificantFieldsChanged
  class << self
    def call(env)
      env.curation_concern.title != env.attributes[:title] || env.attributes[:uploaded_files].present?
    end
  end
end