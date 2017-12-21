module Hyrax
  module Serializers
    def to_s
      if title.present?
        if title.is_a? String
          title
        else
          title.join(' | ')
        end
      elsif label.present?
        label
      else
        'No Title'
      end
    end
  end
end
