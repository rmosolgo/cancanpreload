GraphqlSchema = GraphQL::Schema.define do
  query Types::Query
  use GraphQL::Batch
  authorization(CanCanWithPreloadingStrategy)
  enable_preloading
end
