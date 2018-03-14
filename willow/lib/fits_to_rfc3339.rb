class FitsToRfc3339
  attr_reader :date_value

  class << self
    def call(date_value)
      new(date_value).call
    end
  end

  private
  def candidate_regexen
    [
      '%Y:%m:%d %H:%M:%S%Z',
      '%Y:%m:%d %H:%M:%S',
      '%Y:%m:%d',
      '%Y:%m',
      '%Y'
    ]
  end

  def initialize(date_value)
    @date_value=date_value
  end

  public
  def call(formats=candidate_regexen)
    ::Array.wrap(formats).each do |format|
      begin
        return ::DateTime.strptime(date_value, format).rfc3339
      rescue ArgumentError
        next
      rescue TypeError
        break
      end
    end
    ::Time.at(0).rfc3339
  end
end