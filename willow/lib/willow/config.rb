module Willow
  class Config
     def self.institution_name
       ENV["INSTITUTION_NAME"]
     end

     def self.institution_name_full
       ENV["INSTITUTION_NAME_FULL"]
     end

     def self.institution_logo
       ENV["INSTITUTION_LOGO"]
     end
  end
end