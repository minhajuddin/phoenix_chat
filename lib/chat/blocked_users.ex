defmodule Chat.BlockedUsers do

  def start_link do
    Agent.start_link fn -> %{ "lobby" => "Common Lobby", "water-cooler" => "Water Cooler" } end, name: :topics_agent
  end

end

