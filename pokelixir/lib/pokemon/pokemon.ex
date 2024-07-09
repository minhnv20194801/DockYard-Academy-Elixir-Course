defmodule Pokemon do
  defstruct [
    :id,
    :name,
    :hp,
    :attack,
    :defense,
    :special_attack,
    :special_defense,
    :speed,
    :height,
    :weight,
    :types
  ]

  def get(name) do
    url = "https://pokeapi.co/api/v2/pokemon/#{name}"
    Finch.start_link(name: Finch)

    response =
      Finch.build(:get, url)
      |> Finch.request!(Finch)

    response = Jason.decode!(response.body)

    %Pokemon{
      id: response["id"],
      name: response["name"],
      hp: Enum.at(response["stats"], 0)["base_stat"],
      attack: Enum.at(response["stats"], 1)["base_stat"],
      defense: Enum.at(response["stats"], 2)["base_stat"],
      special_attack: Enum.at(response["stats"], 3)["base_stat"],
      special_defense: Enum.at(response["stats"], 4)["base_stat"],
      speed: Enum.at(response["stats"], 5)["base_stat"],
      height: response["height"],
      weight: response["weight"],
      types:
        Enum.map(response["types"], fn type_map ->
          type_map["type"]["name"]
        end)
    }
  end

  def all() do
    get_from_url_list("https://pokeapi.co/api/v2/pokemon")
  end

  def get_from_url_list(url) when url == nil do
    []
  end

  def get_from_url_list(url) do
    Finch.start_link(name: Finch)

    response =
      Finch.build(:get, url)
      |> Finch.request!(Finch)

    response = Jason.decode!(response.body)
    IO.puts(url)
    Enum.map(response["results"], fn pokemon_map ->
      get(pokemon_map["name"])
    end) ++ get_from_url_list(response["next"])
    |> List.flatten()
  end
end
