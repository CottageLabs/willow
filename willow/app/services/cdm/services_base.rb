module Cdm
  class ServicesBase
    class << self
      private

      def authority_name
        raise 'Must override authority name in derived classes'
      end

      def internationalisation_root
        'rdss.'
      end

      def authority
        ::Qa::Authorities::Local.subauthority_for(authority_name)
      end

      def symbols_for
        authority.all.map { |x| x[:id].underscore.downcase.intern }
      end

      public

      def select_all_options
        symbols_for.map do |x|
          [
            I18n.t("#{internationalisation_root}#{x.to_s.underscore.downcase}"),
            x.to_s.underscore.downcase.intern
          ]
        end
      end
    end
  end
end
