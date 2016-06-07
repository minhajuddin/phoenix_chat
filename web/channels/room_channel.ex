defmodule Chat.RoomChannel do
  use Phoenix.Channel

  def join("rooms:" <> _suff = topic, _message, socket) do
    #socket.assigns.username
    {:ok, socket}
  end

  def handle_in("msg", %{"body" => body}, socket) do
    broadcast socket, "msg", %{body: body, username: socket.assigns.username}
    {:noreply, socket}
  end

  intercept ["msg"]
  def handle_out("msg", %{username: sender} = body, socket) do
    # should I filter this message?
    if !Chat.BlockedUsers.user_blocked?(socket.assigns.username, sender) do
      push socket, "msg", body
    end
    {:noreply, socket}
  end

end
