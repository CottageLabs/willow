Qa::Authorities::Local.class_eval do
  # extend qa local
  autoload :JsonFileBasedAuthority

  # TODO: Seems to register json vocab only after I add it
  # Qa::Authorities::Local.registry.add('file_use',
  #   'Qa::Authorities::Local::JsonFileBasedAuthority')

  class << self
    # Local sub-authorities for JSON files in the subauthorities_path
    def json_names
      unless Dir.exist? subauthorities_path
        raise Qa::ConfigDirectoryNotFound, "There's no directory at #{subauthorities_path}. You must create it in order to use local authorities"
      end
      Dir.entries(subauthorities_path).map { |f| File.basename(f, ".json") if f =~ /json$/ }.compact
    end

    private

      def register_defaults(reg)
        names.each do |name|
          reg.add(name, 'Qa::Authorities::Local::FileBasedAuthority')
        end
        json_names.each do |name|
          reg.add(name, 'Qa::Authorities::Local::JsonFileBasedAuthority')
        end
      end
  end
end
