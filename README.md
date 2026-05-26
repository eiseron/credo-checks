# eiseron_credo_checks

Custom [Credo](https://github.com/rrrene/credo) checks for Eiseron Products.

## Installation

Add to your project's `mix.exs`:

```elixir
def deps do
  [
    {:eiseron_credo_checks,
     git: "https://github.com/eiseron/credo-checks.git",
     tag: "v0.1.0",
     only: [:dev, :test],
     runtime: false}
  ]
end
```

Once the package is published to Hex (planned), the consumption switches to:

```elixir
{:eiseron_credo_checks, "~> 0.1", only: [:dev, :test], runtime: false}
```

## Usage

In `.credo.exs`, register the modules to be loaded and enable the checks you want:

```elixir
%{
  configs: [
    %{
      name: "default",
      requires: [],
      checks: %{
        enabled: [
          {Eiseron.Credo.Check.Design.NoSideEffectsInTransformer, []},
          {Eiseron.Credo.Check.Readability.NoComments, []},
          {Eiseron.Credo.Check.Refactor.StrictFunctionArity, [max_arity: 3]},
          {Eiseron.Credo.Check.Testing.OneAssertPerTest, []}
        ]
      }
    }
  ]
}
```

Modules are auto-loaded by mix; no `requires:` entries needed.

## Checks

### `Eiseron.Credo.Check.Design.NoSideEffectsInTransformer`

Enforces that functions named with pure-transformer prefixes (`build_`, `compute_`, `calculate_`, `classify_`, `determine_`, `parse_`, `format_`, `encode_`) do not call `Repo.*`, broadcasters, `DateTime.utc_now/0` or other side effects. Pure functions take state as an argument; effectful functions live behind a coordinator boundary.

### `Eiseron.Credo.Check.Readability.NoComments`

Bans inline source comments. Encourages descriptive identifiers and the use of `@moduledoc` / `@doc` for documentation. Allows `# credo:disable-for-next-line` and `# ---` style separators.

### `Eiseron.Credo.Check.Refactor.StrictFunctionArity`

Enforces a max function arity (default: 3). Functions with more arguments are forced to accept a single struct or map argument, improving callsite legibility.

### `Eiseron.Credo.Check.Testing.OneAssertPerTest`

Limits each `test` block to a single `assert`/`refute`. Pushes apart concerns and yields more granular failure signals.

## License

[Apache License 2.0](LICENSE.md) — open-source, permissive. See [NOTICE](NOTICE) for attribution.

## Source

Maintained at `gitlab.com/eiseron/stack/credo` (private, source of truth); mirrored to `github.com/eiseron/credo-checks` (public) for installation via `mix`.
