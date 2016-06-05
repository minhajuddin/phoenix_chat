defmodule Chat.RoomController do
  use Chat.Web, :controller

  def show(conn, %{"id" => id}) do
    # the messages, and a textbox
    render conn, :show, id: id
  end

  def private(conn, _params) do
    redirect conn, to: "/room/#{random_room_name}"
    # create a room
    # send this guy there
  end


  defp random_room_name do
    :crypto.strong_rand_bytes(32) |> Base.hex_encode32
  end
end
