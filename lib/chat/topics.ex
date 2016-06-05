defmodule Chat.Topics do
  # add a topic
  def add_topic(name) do
    key = name |> String.downcase |> String.replace(~r/[^a-z0-9-]+/, "-")
    Agent.update :topics_agent, fn(map)-> Map.put(map, key, name) end
  end

  # list all the topics
  def list_topics do
    Agent.get :topics_agent, fn(map)-> map end
  end


  def start_link do
    Agent.start_link fn -> %{ "lobby" => "Common Lobby", "water-cooler" => "Water Cooler" } end, name: :topics_agent
  end
end
