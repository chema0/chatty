# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Chatty.Repo.insert!(%Chatty.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Faker.start()

alias Chatty.Chats.Chat
alias Chatty.{Chats, Accounts, Repo}

Repo.insert!(%Chat{name: "Chat 1", description: "This is test chat 1!"})
Repo.insert!(%Chat{name: "Chat 2", description: "This is test chat 2!"})

for _n <- 1..2 do
  name = Faker.Person.first_name()
  email = "#{String.downcase(name)}@chatty.io"
  Accounts.register_user(%{email: email, password: "itZaPassw0rd!"})
end

for _n <- 1..100 do
  Chats.create_message(%{
    content: Faker.Lorem.sentence(),
    chat_id: Enum.random([1, 2]),
    sender_id: Enum.random([1, 2])
  })
end
