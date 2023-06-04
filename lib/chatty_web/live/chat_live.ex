defmodule ChattyWeb.ChatLive do
  use ChattyWeb, :live_view

  @topic "chat"

  def mount(_params, _session, socket) do
    if connected?(socket) do
      ChattyWeb.Endpoint.subscribe(@topic)
    end

    socket =
      socket
      |> assign(username: username())
      |> assign(messages: [])
      |> assign(:text_value, nil)

    {:ok, socket}
  end

  def handle_info(%{event: "message", payload: message}, socket) do
    IO.puts("New message from #{message.name} -> #{inspect(message.text)}")
    {:noreply, assign(socket, messages: socket.assigns.messages ++ [message])}
  end

  def handle_event("change", %{"text" => value}, socket) do
    socket = assign(socket, :text_value, value)
    {:noreply, socket}
  end

  def handle_event("send", %{"text" => text}, socket) do
    ChattyWeb.Endpoint.broadcast(@topic, "message", %{text: text, name: socket.assigns.username})
    IO.inspect(socket.assigns.messages)
    socket = assign(socket, :text_value, nil)
    {:noreply, socket}
  end

  defp username do
    "User #{:rand.uniform(100)}"
  end

  def render(assigns) do
    ~H"""
    <main class="h-screen overflow-hidden flex items-center justify-center">
      <div class="flex-1 p:2 justify-between flex flex-col h-screen">
        <div class="flex sm:items-center justify-between py-3 border-b-2 border-gray-200 px-4">
          <div class="relative flex items-center space-x-4">
            <div class="relative">
              <span class="absolute text-green-500 right-0 bottom-0">
                <svg width="14" height="14">
                  <circle cx="10" cy="10" r="8" fill="currentColor"></circle>
                </svg>
              </span>
              <img
                src="https://images.unsplash.com/photo-1549078642-b2ba4bda0cdb?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=facearea&amp;facepad=3&amp;w=144&amp;h=144"
                alt=""
                class="w-10 h-10 rounded-full"
              />
            </div>
            <div class="flex flex-col leading-tight">
              <span class="text-gray-700 mr-3"><%= @username %></span>
              <span class="text-sm text-gray-600">Software Engineer</span>
            </div>
          </div>
          <div class="flex items-center space-x-2">
            <button class="inline-flex hover:bg-indigo-50 rounded-full p-2" type="button">
              <.icon name="hero-magnifying-glass-solid" class="w-6 h-6 mx-auto bg-stone-700" />
            </button>
          </div>
        </div>
        <div
          id="messages"
          class="flex flex-col space-y-4 p-3 overflow-y-auto scrollbar-thumb-blue scrollbar-thumb-rounded scrollbar-track-blue-lighter scrollbar-w-2 scrolling-touch"
        >
          <.message_stack messages={@messages} />
          <.message
            type={:sender}
            content="Your error message says permission denied, npm global installs must be given root privileges."
          />

          <%!-- <.message_stack messages={[
            "Command was run with root privileges. I'm sure about that.",
            "I've update the description so it's more obviously now",
            "FYI https://askubuntu.com/a/700266/510172",
            "Check the line above (it ends with a # so, I'm running it as root ) <pre># npm install -g @vue/devtools</pre>"
          ]} /> --%>
          <div class="chat-message">
            <div class="flex items-end justify-end">
              <div class="flex flex-col space-y-2 text-xs max-w-xs mx-2 order-1 items-end">
                <div>
                  <span class="px-4 py-2 rounded-lg inline-block rounded-br-none bg-blue-600 text-white ">
                    Any updates on this issue? I'm getting the same error when trying to install devtools. Thanks
                  </span>
                </div>
              </div>
              <img
                src="https://images.unsplash.com/photo-1590031905470-a1a1feacbb0b?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=facearea&amp;facepad=3&amp;w=144&amp;h=144"
                alt="My profile"
                class="w-6 h-6 rounded-full order-2"
              />
            </div>
          </div>
          <div class="chat-message">
            <div class="flex items-end">
              <div class="flex flex-col space-y-2 text-xs max-w-xs mx-2 order-2 items-start">
                <div>
                  <span class="px-4 py-2 rounded-lg inline-block rounded-bl-none bg-gray-300 text-gray-600">
                    Thanks for your message David. I thought I'm alone with this issue. Please, ? the issue to support it :)
                  </span>
                </div>
              </div>
              <img
                src="https://images.unsplash.com/photo-1549078642-b2ba4bda0cdb?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=facearea&amp;facepad=3&amp;w=144&amp;h=144"
                alt="My profile"
                class="w-6 h-6 rounded-full order-1"
              />
            </div>
          </div>
          <div class="chat-message">
            <div class="flex items-end justify-end">
              <div class="flex flex-col space-y-2 text-xs max-w-xs mx-2 order-1 items-end">
                <div>
                  <span class="px-4 py-2 rounded-lg inline-block bg-blue-600 text-white ">
                    Are you using sudo?
                  </span>
                </div>
                <div>
                  <span class="px-4 py-2 rounded-lg inline-block rounded-br-none bg-blue-600 text-white ">
                    Run this command sudo chown -R `whoami` /Users/{{your_user_profile}}/.npm-global/ then install the package globally without using sudo
                  </span>
                </div>
              </div>
              <img
                src="https://images.unsplash.com/photo-1590031905470-a1a1feacbb0b?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=facearea&amp;facepad=3&amp;w=144&amp;h=144"
                alt="My profile"
                class="w-6 h-6 rounded-full order-2"
              />
            </div>
          </div>
          <div class="chat-message">
            <div class="flex items-end">
              <div class="flex flex-col space-y-2 text-xs max-w-xs mx-2 order-2 items-start">
                <div>
                  <span class="px-4 py-2 rounded-lg inline-block bg-gray-300 text-gray-600">
                    It seems like you are from Mac OS world. There is no /Users/ folder on linux ?
                  </span>
                </div>
                <div>
                  <span class="px-4 py-2 rounded-lg inline-block rounded-bl-none bg-gray-300 text-gray-600">
                    I have no issue with any other packages installed with root permission globally.
                  </span>
                </div>
              </div>
              <img
                src="https://images.unsplash.com/photo-1549078642-b2ba4bda0cdb?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=facearea&amp;facepad=3&amp;w=144&amp;h=144"
                alt="My profile"
                class="w-6 h-6 rounded-full order-1"
              />
            </div>
          </div>
          <div class="chat-message">
            <div class="flex items-end justify-end">
              <div class="flex flex-col space-y-2 text-xs max-w-xs mx-2 order-1 items-end">
                <div>
                  <span class="px-4 py-2 rounded-lg inline-block rounded-br-none bg-blue-600 text-white ">
                    yes, I have a mac. I never had issues with root permission as well, but this helped me to solve the problem
                  </span>
                </div>
              </div>
              <img
                src="https://images.unsplash.com/photo-1590031905470-a1a1feacbb0b?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=facearea&amp;facepad=3&amp;w=144&amp;h=144"
                alt="My profile"
                class="w-6 h-6 rounded-full order-2"
              />
            </div>
          </div>
          <div class="chat-message">
            <div class="flex items-end">
              <div class="flex flex-col space-y-2 text-xs max-w-xs mx-2 order-2 items-start">
                <div>
                  <span class="px-4 py-2 rounded-lg inline-block bg-gray-300 text-gray-600">
                    I get the same error on Arch Linux (also with sudo)
                  </span>
                </div>
                <div>
                  <span class="px-4 py-2 rounded-lg inline-block bg-gray-300 text-gray-600">
                    I also have this issue, Here is what I was doing until now: #1076
                  </span>
                </div>
                <div>
                  <span class="px-4 py-2 rounded-lg inline-block rounded-bl-none bg-gray-300 text-gray-600">
                    even i am facing
                  </span>
                </div>
              </div>
              <img
                src="https://images.unsplash.com/photo-1549078642-b2ba4bda0cdb?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=facearea&amp;facepad=3&amp;w=144&amp;h=144"
                alt="My profile"
                class="w-6 h-6 rounded-full order-1"
              />
            </div>
          </div>
        </div>

        <div class="flex items-center border-t py-4 px-2">
          <div>
            <button class="inline-flex hover:bg-indigo-50 rounded-full p-2" type="button">
              <.icon name="hero-paper-clip-solid" class="w-6 h-6 mx-auto bg-stone-600" />
            </button>
          </div>
          <form phx-change="change" phx-submit="send" class="w-full flex items-center">
            <input
              autofocus
              type="text"
              name="text"
              placeholder="Write something.."
              value={@text_value}
              class="w-full rounded-xl border border-gray-300 focus:border-blue-300 mx-4"
            />
            <button type="submit" class="inline-flex hover:bg-indigo-50 rounded-full p-2">
              <.icon name="hero-paper-airplane-solid" class="w-6 h-6 mx-auto bg-stone-600" />
            </button>
          </form>
          <%!-- <.form for={@form} multipart phx-change="change_message">
              <input
                autofocus
                class="w-full rounded-xl border border-gray-300 focus:border-blue-300"
                type="text"
                id={@field.id}
                name={@field.name}
                value={@field.value}
                placeholder="Write something.."
              />
              <button
                type="submit"
                class="inline-flex hover:bg-indigo-50 rounded-full p-2"
                type="button"
              >
                <.icon name="hero-paper-airplane-solid" class="w-6 h-6 mx-auto bg-stone-600" />
              </button>
            </.form> --%>
        </div>
      </div>
    </main>
    """
  end

  attr(:type, :atom, required: true)
  attr(:is_last_message?, :boolean, default: false)
  attr(:content, :string, required: true)

  def message(%{type: :receiver} = assigns) do
    ~H"""
    <div>
      <%= if @is_last_message? do %>
        <span class="px-4 py-2 mx-2 rounded-lg inline-block rounded-bl-none text-sm bg-gray-200 text-gray-600">
          <%= @content %>
        </span>
      <% else %>
        <span class="px-4 py-2 mx-2 rounded-lg inline-block text-sm bg-gray-200 text-gray-600">
          <%= @content %>
        </span>
      <% end %>
    </div>
    """
  end

  def message(%{type: :sender} = assigns) do
    ~H"""
    <div class="flex items-end justify-end">
      <div class="flex flex-col space-y-2 text-sm max-w-xs mx-2 order-1 items-end">
        <div>
          <span class="px-4 py-2 rounded-lg inline-block rounded-br-none text-sm bg-blue-500 text-white ">
            <%= @content %>
          </span>
        </div>
      </div>
    </div>
    """
  end

  attr(:messages, :list, default: [])

  def message_stack(assigns) do
    ~H"""
    <div class="flex items-end">
      <div class="flex flex-col space-y-2 text-xs max-w-xs mx-1 order-2 items-start">
        <%= for {msg, i} <- Enum.with_index(@messages) do %>
          <% IO.puts("msg: #{inspect(msg)}") %>
          <.message
            type={:receiver}
            content={msg.text}
            is_last_message?={i === length(@messages) - 1}
          />
        <% end %>

        <%!-- <.message
          type={:receiver}
          content="Command was run with root privileges. I'm sure about that."
        />
        <div>
          <span class="px-4 py-2 rounded-lg inline-block bg-gray-300 text-gray-600">
            I've update the description so it's more obviously now
          </span>
        </div>
        <div>
          <span class="px-4 py-2 rounded-lg inline-block bg-gray-300 text-gray-600">
            FYI https://askubuntu.com/a/700266/510172
          </span>
        </div>
        <div>
          <span class="px-4 py-2 rounded-lg inline-block rounded-bl-none bg-gray-300 text-gray-600">
            Check the line above (it ends with a # so, I'm running it as root ) <pre># npm install -g @vue/devtools</pre>
          </span>
        </div> --%>
      </div>
      <img
        src="https://images.unsplash.com/photo-1549078642-b2ba4bda0cdb?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=facearea&amp;facepad=3&amp;w=144&amp;h=144"
        alt="My profile"
        class="w-6 h-6 rounded-full order-1"
      />
    </div>
    """
  end
end
