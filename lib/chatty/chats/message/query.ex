defmodule Chatty.Chats.Message.Query do
  import Ecto.Query
  alias Chatty.Chats.Message

  def base, do: Message

  # def for_chat(query \\ base(), chat_id) do
  def for_chat(query \\ base(), chat_id) do
    query
    |> where([m], m.chat_id == ^chat_id)
    |> order_by([m], {:desc, m.inserted_at})

    # TODO: add limit
    # |> limit(10)
    # |> subquery()
    # |> order_by([m], {:asc, m.inserted_at})
  end
end
