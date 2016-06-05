defmodule Chat.TopicController do
  use Chat.Web, :controller

  def new(conn, _params) do
    render conn, :new
  end

  def create(conn, %{"topic" => %{"name" => name}}) do
    Chat.Topics.add_topic(name)
    redirect conn, to: "/room/lobby"
  end

end
