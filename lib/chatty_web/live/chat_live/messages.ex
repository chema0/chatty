defmodule ChattyWeb.ChatLive.Messages do
  alias Chatty.Accounts.User
  use ChattyWeb, :html

  attr(:user, User, required: true)
  attr(:messages, :list, default: [])

  def list_messages(assigns) do
    ~H"""
    <div class="flex flex-col-reverse h-full space-y-4 p-3 overflow-y-hidden scrollbar-thumb-blue scrollbar-thumb-rounded scrollbar-track-blue-lighter scrollbar-w-2 scrolling-touch">
      <%= for {_, user_messages} <- @messages do %>
        <.messages_stack messages={user_messages} type={sender_or_recipient(user_messages, @user)} />
      <% end %>
    </div>
    """
  end

  attr(:messages, :list, default: [])
  attr(:type, :atom, required: true)

  def messages_stack(%{type: :sender} = assigns) do
    ~H"""
    <div class="flex flex-row-reverse items-end">
      <div class="flex flex-col space-y-2 text-xs max-w-xs mx-1 order-2">
        <%= for {msg, i} <- @messages |> Enum.reverse |> Enum.with_index do %>
          <.message_details
            type={@type}
            content={msg.content}
            is_last_message={i === length(@messages) - 1}
          />
        <% end %>
      </div>
      <img
        src="https://images.unsplash.com/photo-1640951613773-54706e06851d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80"
        alt="My profile"
        class="w-6 h-6 rounded-full order-1"
      />
    </div>
    """
  end

  def messages_stack(%{type: :recipient} = assigns) do
    ~H"""
    <div class="flex items-end">
      <div class="flex flex-col space-y-2 text-xs max-w-xs mx-1 order-2 items-start">
        <%= for {msg, i} <- @messages |> Enum.reverse |> Enum.with_index do %>
          <.message_details
            type={@type}
            content={msg.content}
            is_last_message={i === length(@messages) - 1}
          />
        <% end %>
      </div>
      <img
        src="https://images.unsplash.com/photo-1640960543409-dbe56ccc30e2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80"
        alt="My profile"
        class="w-6 h-6 rounded-full order-1"
      />
    </div>
    """
  end

  attr(:type, :atom, required: true)
  attr(:content, :string, required: true)
  attr(:is_last_message, :boolean, required: true)

  def message_details(%{type: :recipient} = assigns) do
    ~H"""
    <span class={
      if @is_last_message do
        "px-4 py-2 mx-2 rounded-lg rounded-bl-none inline-block text-sm bg-gray-200 text-gray-600"
      else
        "px-4 py-2 mx-2 rounded-lg inline-block text-sm bg-gray-200 text-gray-600"
      end
    }>
      <%= @content %>
    </span>
    """
  end

  def message_details(%{type: :sender} = assigns) do
    ~H"""
    <div class="flex flex-col space-y-2 text-sm max-w-xs mx-2 order-1 items-end">
      <span class={
        if @is_last_message do
          "px-4 py-2 rounded-lg inline-block rounded-br-none text-sm bg-blue-500 text-white"
        else
          "px-4 py-2 rounded-lg inline-block text-sm bg-blue-500 text-white"
        end
      }>
        <%= @content %>
      </span>
    </div>
    """
  end

  defp sender_or_recipient([], _), do: :sender

  defp sender_or_recipient([message | _], user) do
    if message.sender_id == user.id, do: :sender, else: :recipient
  end

  # defp sender_or_recipient(message, user) do
  # if message.sender_id == user.id, do: :sender, else: :recipient
  # end
end
