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


### Without Auth

```
Processing by GraphqlController#execute as */*
  Parameters: {"query"=>"{\n  things {\n    name \n    children {\n      name\n    }  \n  }\n}", "variables"=>nil, "operationName"=>nil, "graphql"=>{"query"=>"{\n  things {\n    name \n    children {\n      name\n    }  \n  }\n}", "variables"=>nil, "operationName"=>nil}}
  User Load (0.1ms)  SELECT  "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
  ↳ app/controllers/graphql_controller.rb:7
  Thing Load (0.1ms)  SELECT "things".* FROM "things" WHERE "things"."parent_id" IS NULL
  ↳ /Users/rmosolgo/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/bundler/gems/graphql-ruby-fb040d08a48f/lib/graphql/execution/execute.rb:201
  Thing Load (0.3ms)  SELECT "things".* FROM "things" WHERE "things"."parent_id" IN (?, ?, ?)  [["parent_id", 1], ["parent_id", 5], ["parent_id", 9]]
  ↳ /Users/rmosolgo/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/bundler/gems/graphql-ruby-fb040d08a48f/lib/graphql/field.rb:326
Completed 200 OK in 46ms (Views: 0.4ms | ActiveRecord: 1.9ms)
```

### With Auth

```
Started POST "/graphql" for 127.0.0.1 at 2018-04-20 09:07:08 -0400
Processing by GraphqlController#execute as */*
  Parameters: {"query"=>"{\n  things {\n    name \n    children {\n      name\n    }  \n  }\n}", "variables"=>nil, "operationName"=>nil, "graphql"=>{"query"=>"{\n  things {\n    name \n    children {\n      name\n    }  \n  }\n}", "variables"=>nil, "operationName"=>nil}}
  User Load (0.1ms)  SELECT  "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
  ↳ app/controllers/graphql_controller.rb:7
  Thing Load (0.2ms)  SELECT "things".* FROM "things" WHERE "things"."parent_id" IS NULL
  ↳ /Users/rmosolgo/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/bundler/gems/graphql-ruby-fb040d08a48f/lib/graphql/execution/execute.rb:201
  Thing Load (0.3ms)  SELECT "things".* FROM "things" WHERE "things"."parent_id" IN (?, ?, ?)  [["parent_id", 1], ["parent_id", 5], ["parent_id", 9]]
  ↳ /Users/rmosolgo/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/bundler/gems/graphql-ruby-fb040d08a48f/lib/graphql/field.rb:326
  Thing Load (0.3ms)  SELECT "things".* FROM "things" WHERE "things"."parent_id" = ?  [["parent_id", 1]]
  ↳ /Users/rmosolgo/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/bundler/gems/graphql-ruby-fb040d08a48f/lib/graphql/execution/execute.rb:201
  Thing Load (0.3ms)  SELECT "things".* FROM "things" WHERE "things"."parent_id" = ?  [["parent_id", 5]]
  ↳ /Users/rmosolgo/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/bundler/gems/graphql-ruby-fb040d08a48f/lib/graphql/execution/execute.rb:201
  Thing Load (1.0ms)  SELECT "things".* FROM "things" WHERE "things"."parent_id" = ?  [["parent_id", 9]]
  ↳ /Users/rmosolgo/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/bundler/gems/graphql-ruby-fb040d08a48f/lib/graphql/execution/execute.rb:201
Completed 200 OK in 62ms (Views: 0.6ms | ActiveRecord: 4.0ms)
```

### With CanCanWithPreloadingStrategy

(see `app/graphql/can_can_with_preloading_strategy.rb`)

```
Started POST "/graphql" for 127.0.0.1 at 2018-04-20 09:37:22 -0400
Processing by GraphqlController#execute as */*
  Parameters: {"query"=>"{\n  things {\n    name \n    children {\n      name\n    }  \n  }\n}", "variables"=>nil, "operationName"=>nil, "graphql"=>{"query"=>"{\n  things {\n    name \n    children {\n      name\n    }  \n  }\n}", "variables"=>nil, "operationName"=>nil}}
  User Load (0.2ms)  SELECT  "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
  ↳ app/controllers/graphql_controller.rb:7
  Thing Load (0.2ms)  SELECT "things".* FROM "things" WHERE "things"."parent_id" IS NULL
  ↳ /Users/rmosolgo/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/bundler/gems/graphql-ruby-fb040d08a48f/lib/graphql/execution/execute.rb:201
  Thing Load (0.2ms)  SELECT "things".* FROM "things" WHERE "things"."parent_id" IN (?, ?, ?)  [["parent_id", 1], ["parent_id", 5], ["parent_id", 9]]
  ↳ /Users/rmosolgo/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/bundler/gems/graphql-ruby-fb040d08a48f/lib/graphql/field.rb:326
Completed 200 OK in 10ms (Views: 0.7ms | ActiveRecord: 0.6ms)
```
