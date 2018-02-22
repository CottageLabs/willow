require_relative '../../lib/rdss/messaging/message_generation_subscriber.rb'

RdssCdm.subscribe(Rdss::Messaging::MessageGenerationSubscriber.new)

#Hyrax::CurationConcern.actor_factory.insert_before Hyrax::Actors::CreateWithFilesActor, Rdss::Messaging::Actors::InitialiseMessageActor
