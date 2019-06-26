class TestSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  use GraphQL::Subscriptions::ActionCableSubscriptions, redis: Redis.new
  subscription(Types::SubscriptionType)
end
