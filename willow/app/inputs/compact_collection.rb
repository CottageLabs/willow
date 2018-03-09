module CompactCollection
  def collection
    @collection ||= begin
      val = object[attribute_name]
      col = val.respond_to?(:to_ary) ? val.to_ary : val
      col.reject { |value| value.to_s.strip.blank? }.presence || ['']
    end
  end
end