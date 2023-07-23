defmodule ChattyWeb.ChatLive.Chats do
  use ChattyWeb, :html

  def sidebar(assigns) do
    ~H"""
    <aside
      id="default-sidebar"
      class="z-40 w-64 h-full transition-transform -translate-x-full sm:translate-x-0"
      aria-label="Sidebar"
    >
      <div class="h-full overflow-y-auto bg-gray-50 dark:bg-gray-900">
        <.chats_list chats={@chats} chat={@chat} live_action={@live_action} />
      </div>
    </aside>
    """
  end

  def chats_list(assigns) do
    ~H"""
    <ul>
      <li :for={chat <- @chats}>
        <.link
          navigate={~p"/chats/#{chat.id}"}
          class={"#{if @live_action == :show && @chat.id == chat.id, do: "bg-blue-700"} flex items-center p-2 text-base font-normal text-gray-900 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700"}
        >
          <%!-- <.chat_icon /> --%>
          <span class="ml-3"><%= chat.name %></span>
        </.link>
      </li>
    </ul>
    """
  end
end
