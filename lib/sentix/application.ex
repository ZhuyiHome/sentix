defmodule Sentix.Application do
  # define application
  use Application

  @moduledoc false
  # Application callback to start any needed resources

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      worker(Cachex, [ Sentix ]),
      worker(:exec, [[ :root, portexe: Sentix.Bridge.locate_port() ]])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Sentix.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
