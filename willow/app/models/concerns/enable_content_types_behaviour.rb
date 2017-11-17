# Shared functionality for Work models
# adds methods to check if content type is enabled, or new content for this type is disabled
module EnableContentTypesBehaviour
  extend ActiveSupport::Concern

  module ClassMethods
    # Method to determine if content of this type is enabled by environment variables
    # Checks if ENV[ENABLE_<type>_CONTENT_TYPE] == 'true'
    # NB: RdssDataset is always enabled
    def content_type_enabled?
      # RdssDataset should always return true
      return true if(self == RdssDataset)
      # check environment variable
      ENV["ENABLE_#{content_type_env_var_str}_CONTENT_TYPE"] == 'true'
    end
    
    # Method to determine if creation of new content for this type is disabled by environment variables
    # Checks if ENV[DISABLE_NEW_<type>_CONTENT] == 'true'
    def new_content_of_type_disabled?
      ENV["DISABLE_NEW_#{content_type_env_var_str}_CONTENT"] == 'true'
    end

    # content type name in the correct format for environment variables
    # returns the uppercase and underscore version of the classname, E.G RDSS_DATASET
    def content_type_env_var_str
      self.name.underscore.upcase # E.G "RdssDataset" => "RDSS_DATASET"
    end
  end
end