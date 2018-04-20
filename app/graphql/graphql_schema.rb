GraphqlSchema = GraphQL::Schema.define do
  query Types::Query
  use GraphQL::Batch

  enable_preloading
end
