defmodule Chat.BlockedUsers do

  # block user
  def block_user(current_username, blocked_username) do
    Agent.update(__MODULE__, fn(map)->
      blocked_users = map[current_username] || [] #=> ["u1", "u2"]
      blocked_users = [blocked_username | blocked_users] #=> ["b1", "u1", "u2"]
      Map.put(map, current_username, blocked_users)
    end)
  end

  # is a user blocked by the current user?
  def user_blocked?(current_username, message_from) do
    blocked_users = Agent.get(__MODULE__, fn(map)->
      map[current_username] || []
    end)

    message_from in blocked_users # "spammy_guy" in ["u1", "u2"]
  end


  # username => [ .... ]
  # %{
    # "username" => ["blocked_user1", "blocked_user2"],
    # }
  def start_link do
    Agent.start_link fn -> Map.new end, name: __MODULE__
  end

end

