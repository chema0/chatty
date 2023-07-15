defmodule Chatty.Repo.Migrations.CreateChats do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add :name, :string
      add :description, :string

      timestamps()
    end
  end
end
