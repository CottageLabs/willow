# This class builds classes to return numeric enumeration values from json enumerations of the form:
#
#     "sectionName": [
#       'value1',
#       'value2',
#       'value3'
#     ]
#
# by setting a constant to the return value for the EnumDecoder.call('sectionName')
# or by subclassing the EnumDecoder.call('sectionName') (This returns a class, so it is entirely appropriate to subclass)
#
# i.e.
# ::Cdm::Messaging::Enumerations::SectionName = ::Cdm::Messaging::Enumerations::Decoder.call('sectionName')
#
# which in this case would be the equivalent of creating the following class
#
# module Cdm
#   module Messaging
#     module Enumerations
#       class SectionName
#         class << self
#           def value1
#             1
#           end
#
#           def value2
#             2
#           end
#
#           def value3
#             3
#           end
#         end
#       end
#     end
#   end
# end
#
# Since we don't actually care about the case of the string names, only their symbolic representation and indexes, no
# translation checks other than conversion to symbols needs to be done. The JSON.parser also contains a symboliser
# which may be more efficient than calling underscore.downcase.intern, but I'd prefer to be more explicit until properly
# testing the Json parser version.
#
module Cdm
  module Messaging
    module Enumerations
      module Decoder
        class << self
          private
          def types
            {
              :file=>::Cdm::Messaging::Enumerations::Decoders::File,
              :api=>::Cdm::Messaging::Enumerations::Decoders::Api
            }
          end

          def define_class_for(section, decoder)
            Class.new do
              decoder.(section).each_with_index do | object, index |
                define_singleton_method(object.underscore.downcase.intern) { (index+1) }
              end
            end
          end

          public
          def call(section, type=:file)
            define_class_for(section, types[type])
          end
        end
      end
    end
  end
end
