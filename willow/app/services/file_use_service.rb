module FileUseService
  mattr_accessor :authority
  self.authority = Qa::Authorities::Local.subauthority_for('file_use')

  def self.select_all_options
    authority.all.map do |element|
      [element[:label], element[:id]]
    end
  end

  def self.select_enum_options
    authority.all.map do |element|
      [element[:id], element[:enum]]
    end
  end

  def self.label(id)
    authority.find(id).fetch('term')
  end

  def self.enum(id)
    authority.find(id).fetch('enum')
  end
end
