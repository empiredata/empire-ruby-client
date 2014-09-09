## 0.3.1

Breaking changes:

  - RubyGem package is now called `empire-client`. The module is still
  called `empire`.
  - `end_user` optional parameter renamed to `enduser`.

Improvements:

  - More detailed error handling

## 0.3

Initial port from Python client.

Features:

  - `connect`
  - `describe`
  - `query`
  - `insert`
  - `walkthrough`
  - `materialize_view`, `drop_view`, and `view_ready?`
  - Optional string parameter `enduser`, when creating an Empire
  instance. This parameter is mandatory for performing materialized
  view operations.
  - `empire.view_materialized_at("viewname")` returns a `Date`
  object with the time the view was last materialized.
