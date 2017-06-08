# module Sufia
#   module Notifications
#     module Subscribers
#       class Console
#
#         def initialize
#
#           ActiveSupport::Notifications.subscribe "create_work.sufia" do |*args|
#
#             Rails.logger.info("SUFIA EVENT RECEIVED!")
#             Rails.logger.info(args)
#           end
#
#         end
#
#
#
#       end
#     end
#   end
# end
