defmodule ChattyWeb.HomeLive do
  use ChattyWeb, :live_view
  alias Chatty.Chats

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="h-full flex flex-col justify-center sm:px-6 lg:px-8">
      <div class="w-full flex flex-col items-center">
        <.icon name="hero-chat-bubble-left-right-solid" class="w-14 h-14 mx-auto bg-blue-600" />
        <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">
          Chatty
        </h2>
      </div>

      <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md flex flex-col space-y-2 mx-8">
        <a
          phx-click="start-new-chat"
          class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-slate-600 hover:bg-slate-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-slate-500 cursor-pointer"
        >
          Start new chat
        </a>
        <a
          href="/chat"
          class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 cursor-pointer"
        >
          Join chat
        </a>
      </div>
    </div>
    """
  end

  def handle_event("start-new-chat", _, socket) do
    new_chat = %{name: "New chat", description: "Write something about this chat.."}

    case Chats.create_chat(new_chat) do
      {:ok, %{id: id}} ->
        {:noreply, push_navigate(socket, to: ~p"/chats/#{id}")}

      _ ->
        {:noreply, socket}
    end
  end
end
