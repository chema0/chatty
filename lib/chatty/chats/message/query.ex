defmodule Chatty.Chats.Message.Query do
  import Ecto.Query
  alias Chatty.Chats.Message

  def base, do: Message

  # def for_chat(query \\ base(), chat_id) do
  def for_chat(chat_id) do
    from m in "messages",
      where: m.chat_id == ^chat_id,
      select: m

    # query
    # |> where([m], m.chat_id == ^chat_id)
    # |> order_by()
  end
end
