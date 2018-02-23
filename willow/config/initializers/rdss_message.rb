require_relative '../../lib/rdss/messaging/message_generation_subscriber.rb'
require_relative '../../lib/rdss/messaging/actors/message_publisher_actor.rb'
require_relative '../../lib/rdss/messaging/workflow/work_approval_publisher.rb'

Rdss::Messaging::Actors::MessagePublisherActor.subscribe(Rdss::Messaging::MessageGenerationSubscriber.new)
Rdss::Messaging::Workflow::WorkApprovalPublisher.subscribe(Rdss::Messaging::MessageGenerationSubscriber.new)

Hyrax::CurationConcern.actor_factory.insert_before Hyrax::Actors::CreateWithFilesActor, Rdss::Messaging::Actors::MessagePublisherActor
