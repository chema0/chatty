defmodule Chatty.Chats.Chat do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chatty.Chats.Message

  schema "chats" do
    field :name, :string
    field :description, :string
    has_many :messages, Message

    timestamps()
  end

  @doc false
  def changeset(chat, attrs) do
    chat
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
