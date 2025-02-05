defmodule Weather do
  @behaviour :cowboy_stream
  @static_dir "priv/static"

  @impl :cowboy_stream
  def init(_stream_id, req, _opts) do
    locate = Weather.Utils.parse_qs(req.qs, "location", "New York")

    case {req.method, req.path} do
      {"GET", "/"} ->
        {
          serve_html_file(
            "lib/views/index.html.heex",
            parse_time: fn (time) -> Weather.Utils.parse_time(time) end,
            weather: Weather.LocationAPI.search(locate),
            location: locate
          ),
          []
        }
      {"GET", path} ->
        {serve_static_file(path), []}
      _ ->
        {response("Not Found", 404), []}
    end
  end

  defp serve_html_file(path, template) do
    body = EEx.eval_file(path, template)

    response(body, 200)
  end

  defp serve_static_file(path) do
    if String.starts_with?(path, "/assets/") do
      file_path = Path.join([@static_dir, String.trim_leading(path, "/")])
      {:ok, content} = File.read(file_path)

      response(content, 200, "text/css")
    else response("Not Found", 404) end
  end

  defp response(body, status, type \\ "text/html") do
    [
      {
        :response,
        status,
        %{
          "Content-Length" => Integer.to_string(byte_size(body)),
          "Content-Type" => type
        },
        body
      },
      :stop
    ]
  end

  @impl :cowboy_stream
  def data(_stream_id, _is_fin, _data, state), do: {[], state}

  @impl :cowboy_stream
  def info(_stream_id, _info, state), do: {[], state}

  @impl :cowboy_stream
  def terminate(_stream_id, _reason, _state), do: :ok

  @impl :cowboy_stream
  def early_error(_stream_id, _reason, _partial_req, resp, _opts), do: resp
end
