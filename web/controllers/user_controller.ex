defmodule Chat.UserController do
  use Chat.Web, :controller

  def block(conn, %{"username" => username, "current_username" => current_username}) do
    Chat.BlockedUsers.block_user(current_username, username)
    redirect conn, to: "/room/lobby"
  end
end
