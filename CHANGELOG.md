## 0.3.4

Breaking changes:

 - Renamed `empire-client.gemspec` to `empire.gemspec`.

## 0.3.3

Breaking changes:

 - RubyGem package is now called `empire`.

## 0.3.2

Fixes:

  - Fixed `connect` when secrets are provided via YAML
  - Correctly demonstrating materialized views in `walkthrough` 

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
