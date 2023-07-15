defmodule Chatty.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :content, :string
      add :sender_id, references(:users), null: false
      add :chat_id, references(:chats), null: false

      timestamps()
    end
  end
end
