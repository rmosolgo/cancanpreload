Types::Thing = GraphQL::ObjectType.define do
  name "Thing"
  authorize :show
  field :name, !types.String
  field :children, !types[!Types::Thing] do
    preload [:children]
  end
  field :parent, Types::Thing
end
