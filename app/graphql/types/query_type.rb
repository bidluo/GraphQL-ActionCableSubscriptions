module Types
  class QueryType < Types::BaseObject

    field :messages, Types::MessageType, null: false
    def messages
        Messages.all
    end
  end
end
