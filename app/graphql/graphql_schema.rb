GraphqlSchema = GraphQL::Schema.define do
  query Types::Query
  use GraphQL::Batch
  authorization(:cancan)
  enable_preloading
end
