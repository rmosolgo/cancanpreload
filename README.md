Test compatibility between cancan and graphql-preload.

Use a query like

```graphql
{
  things {
    name
    children {
      name
    }
  }
}
```

Which loads the children, and check the SQL in the logs.
