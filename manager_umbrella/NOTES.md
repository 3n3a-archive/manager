## Commands Used

```bash

# Generate API Endpoint and Context
mix phx.gen.json Homepage Project projects title:string:unique body:text href:text:unique color:text customBg:text status:enum:draft:live:trash

# Generate HTML Form, with existing Context
mix phx.gen.html Homepage Project projects title:string:unique body:text href:text:unique color:text customBg:text status:enum:draft:live:trash --no-context

```
