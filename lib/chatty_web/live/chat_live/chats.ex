defmodule ChattyWeb.ChatLive.Chats do
  import ChattyWeb.CoreComponents
  use ChattyWeb, :html

  def sidebar(assigns) do
    ~H"""
    <aside
      id="default-sidebar"
      class="fixed top-0 left-0 z-40 w-64 h-screen transition-transform -translate-x-full sm:translate-x-0"
      aria-label="Sidebar"
    >
      <div class="h-full px-3 py-4 overflow-y-auto bg-gray-50 dark:bg-gray-800">
        <.chats_list chats={@chats} chat={@chat} live_action={@live_action} />
      </div>
    </aside>
    """
  end

  def chats_list(assigns) do
    ~H"""
    <ul class="space-y-2">
      <li :for={chat <- @chats}>
        <.link
          navigate={~p"/chats/#{chat.id}"}
          class={"#{if @live_action == :show && @chat.id == chat.id, do: "bg-blue-700"} flex items-center p-2 text-base font-normal text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700"}
        >
          <%!-- <.chat_icon /> --%>
          <span class="ml-3"><%= chat.name %></span>
        </.link>
      </li>
    </ul>
    """
  end
end
