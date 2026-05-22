defmodule EiseronCredoChecks.MixProject do
  use Mix.Project

  @version "0.1.0"
  @source_url "https://gitlab.com/eiseron/stack/credo"

  def project do
    [
      app: :eiseron_credo_checks,
      version: @version,
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: "Custom Credo checks for Eiseron Products.",
      source_url: @source_url,
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  def application, do: [extra_applications: [:logger]]

  defp deps do
    [
      {:credo, "~> 1.7", runtime: false}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      files: ~w(lib LICENSE.md NOTICE README.md mix.exs),
      licenses: ["FSL-1.1-ALv2"],
      links: %{"GitLab" => @source_url}
    ]
  end
end
