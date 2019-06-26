module Types
    class SubscriptionType < Types::BaseObject
        field :new_message, Types::MessageType, null: false

        def new_message
        end
    end
end
