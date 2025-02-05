defmodule Weather.Utils do
  def parse_time(time) do
    resolved_time = String.slice(time, 0, 16) <> ":00Z"

    case DateTime.from_iso8601(resolved_time) do
      {:ok, datetime, _offset} ->
        "#{String.pad_leading(Integer.to_string(datetime.hour), 2, "0")}:#{String.pad_leading(Integer.to_string(datetime.minute), 2, "0")}"
      end
  end

  def parse_qs(qs, key, default \\ "Not Found") do
    URI.query_decoder(qs)
    |> Enum.to_list()
    |> Enum.into(%{})
    |> Map.get(key, default)
  end
end
