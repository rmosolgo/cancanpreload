Types::Query = GraphQL::ObjectType.define do
  name "Query"
  field :things, !types[!Types::Thing], resolve: ->(o, a, c) {
    Thing.where(parent_id: nil)
  }
end
