class CanCanWithPreloadingStrategy < GraphQL::Pro::Access::CanCanStrategy
  # Handle preloaded associations differently, IF:
  # - The relation is preloaded; AND
  # - The required permission is `:show`
  # THEN return the relation without any further filtering.
  #
  # However, if the relation is _not_ preloaded, or requires some other permission level,
  # pass it through to the normal filtering, using `accessible_by`.
  #
  # Adapt this to your application by customizing that first conditional, asking yourself,
  # what are the conditions that we can be _sure_ that `accessible_by` is a no-op?
  def scope(gate, relation)
    if relation.loaded? && gate.role == :show
      relation
    else
      super
    end
  end
end
