defmodule Duper.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Duper.Worker.start_link(arg)
      # {Duper.Worker, arg}
      Duper.Results,
      # { Duper.PathFinder, "D:\\Workspace\\ElixirPrograms\\Chapter 19 - OTP Duper Application\\duper\\deps"},
      { Duper.PathFinder, "."},
      Duper.WorkerSupervisor,
      { Duper.Gatherer, 1},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Duper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
