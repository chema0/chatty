defmodule ChattyWeb.ChatLive.Chat do
  use Phoenix.Component
  alias ChattyWeb.ChatLive.{Messages, Message}

  def show(assigns) do
    ~H"""
    <div class="h-full flex-1 p:2 justify-between flex flex-col">
      <div class="flex sm:items-center justify-between py-3 border-2 border-gray-200 px-4">
        <div class="relative flex items-center space-x-4">
          <img
            src="https://images.unsplash.com/photo-1640951613773-54706e06851d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80"
            alt=""
            class="w-10 h-10 rounded-full"
          />
          <div class="flex flex-col leading-tight">
            <span class="text-gray-700 mr-3"><%= @current_user.email %></span>
            <span class="text-sm text-gray-600">Last seen today at 22:20</span>
          </div>
        </div>
        <div class="flex items-center space-x-2">
          <button class="inline-flex hover:bg-indigo-50 rounded-full p-2" type="button">
            <.icon name="hero-magnifying-glass-solid" class="w-5 h-5 mx-auto bg-stone-700" />
          </button>
        </div>
      </div>
      <Messages.list_messages user={@current_user} messages={@streams.messages} />

      <div class="flex items-center border-t py-4 px-2">
        <button class="hover:bg-indigo-50 rounded-full ml-2" type="button">
          <.icon name="hero-paper-clip-solid" class="w-6 h-6 mx-auto bg-stone-600" />
        </button>
        <form phx-change="change" phx-submit="send" class="w-full flex items-center">
          <%!-- <textarea --%>
          <%!-- rows={1} --%>
          <input
            autofocus
            type="text"
            name="text"
            placeholder="Write something.."
            value={@text_value}
            class="w-full rounded-xl border border-gray-300 focus:border-blue-300 mx-4"
          />
          <button
            disabled={!@text_value}
            type="submit"
            class="hover:enabled:bg-indigo-50 rounded-full mr-2"
          >
            <.icon name="hero-paper-airplane-solid" class="w-6 h-6 mx-auto bg-stone-600" />
          </button>
        </form>
      </div>
    </div>
    """
  end
end
