defmodule Weather.Application do
  use Application

  @compile :native
  @compile {:hipe, [:verbose, :o3]}

  def start(_type, _args) do
    children = [
      {
        Task,
        fn ->
          Esbuild.install_and_run(:weather, ~w())
          Tailwind.install_and_run(:weather, ~w())
        end
      },
      %{
        id: :weather,
        start: {
          :cowboy,
          :start_clear,
          [
            :weather,
            %{
              socket_opts: [port: 3000],
              max_connections: 16_384,
              num_acceptors: 100
            },
            %{
              stream_handlers: [Weather]
            }
          ]
        },
        restart: :permanent,
        shutdown: :infinity,
        type: :supervisor
      }
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Weather.Supervisor)
  end
end
