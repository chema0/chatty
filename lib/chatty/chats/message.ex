defmodule Chatty.Chats.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chatty.Accounts.User
  alias Chatty.Chats.Chat

  schema "messages" do
    field :content, :string
    belongs_to :sender, User
    belongs_to :chat, Chat

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :sender_id, :chat_id])
    |> validate_required([:content, :sender_id, :chat_id])
  end
end
