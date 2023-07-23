defmodule ChattyWeb.ChatLive.Root do
  use ChattyWeb, :live_view
  alias Chatty.Chats, as: ChatsCtx
  alias ChattyWeb.Endpoint
  alias ChattyWeb.ChatLive.{Chats, Chat}

  def mount(_params, _session, socket) do
    {:ok, socket |> assign_chats() |> assign_active_chat()}
  end

  def handle_params(%{"id" => id}, _uri, %{assigns: %{live_action: :show}} = socket) do
    if connected?(socket), do: Endpoint.subscribe("chat:#{id}")

    {:noreply,
     socket
     |> assign_active_chat(id)
     |> assign_active_chat_messages()}
  end

  def handle_params(_params, _uri, socket), do: {:noreply, socket}

  # def handle_info(
  #       %{event: "message", payload: message},
  #       %{assigns: %{chat: %{messages: []}}} = socket
  #     ) do
  #   # {:noreply, assign(socket, messages: [[message]])}
  # end

  # def handle_info(%{event: "message", payload: message}, socket) do
  #   {:noreply, socket}
  # end

  def handle_event("change", %{"text" => value}, socket) do
    socket = assign(socket, :text_value, value)
    {:noreply, socket}
  end

  def handle_event("send", %{"text" => _text}, socket) do
    {:noreply, socket}
  end

  defp assign_chats(socket) do
    assign(socket, :chats, ChatsCtx.list_chats())
  end

  defp assign_active_chat(socket) do
    assign(socket, :chat, nil)
  end

  defp assign_active_chat(socket, id) do
    assign(socket, :chat, ChatsCtx.get_chat!(id))
  end

  defp assign_active_chat_messages(socket) do
    messages = ChatsCtx.last_messages_for(socket.assigns.chat.id)

    oldest_message_id =
      case List.first(messages) do
        nil -> nil
        msg -> msg.id
      end

    socket
    # |> stream(:messages, messages)
    |> stream_configure(:messages, dom_id: &"messages-#{:rand.uniform(1000 + length(&1))}")
    |> stream(
      :messages,
      stack_messages(messages)
    )
    |> assign(:oldest_message_id, oldest_message_id)
  end

  defp stack_messages([]), do: []

  defp stack_messages(messages) do
    chunk_fun = fn message, acc ->
      case acc do
        [] ->
          {:cont, [message]}

        [last_message | _] ->
          if message.sender_id == last_message.sender_id do
            {:cont, [message | acc]}
          else
            {:cont, acc, [message]}
          end
      end
    end

    after_fun = fn
      [] -> {:cont, []}
      acc -> {:cont, acc, []}
    end

    Enum.chunk_while(messages, [], chunk_fun, after_fun)
  end
end
