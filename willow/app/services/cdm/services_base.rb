module Cdm
  class ServicesBase
    include Concerns::SelectBuilder

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
        authority.map{|x| x[:id].underscore.downcase.intern}
      end

      public
      def select_all_options
        symbols_for.map {|x| [I18n.t(internationalisation_root + x.underscore.downcase), x.underscore.downcase.intern]}
      end
    end

  end
end