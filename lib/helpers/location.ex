defmodule Weather.LocationAPI do
  def search(locate) do
    location_response =
      "https://nominatim.openstreetmap.org/search.php?q=#{URI.encode(locate)}&format=jsonv2"
      |> HTTPoison.get!()

    location = Jason.decode!(location_response.body)

    latitude = location |> List.first() |> Map.get("lat")
    longitude = location |> List.first() |> Map.get("lon")

    weather_response =
      "https://api.open-meteo.com/v1/forecast?latitude=#{latitude}&longitude=#{longitude}&hourly=relative_humidity_2m&daily=sunrise,sunset,uv_index_max,precipitation_probability_max,temperature_2m_max,temperature_2m_min&current=snowfall,snow_depth,wind_speed_80m&timezone=auto"
      |> HTTPoison.get!()

    Jason.decode!(weather_response.body)
    |> Map.put("latitude", latitude)
    |> Map.put("longitude", longitude)
  end
end
