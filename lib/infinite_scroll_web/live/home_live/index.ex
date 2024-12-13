# infinite_scroll_web/live/home_live/index.ex
defmodule InfiniteScrollWeb.HomeLive.Index do
  use InfiniteScrollWeb, :live_view

  alias InfiniteScrollWeb.Components.GalleryComponent

  @impl true
  def mount(_params, _session, socket) do
    # * The initial page number is 1
    # *  By using temporary assigns and phx-update,
    # * we don't need to keep anything in memory,
    # * and new elements will be appended to the UI only when there are new ones.
    {:ok,
     socket
     |> assign(page: 1), temporary_assigns: [images: []]}
  end

  # * Map destructuring in Elixir => %{assigns: assigns} = socket implemented as pattern matching
  # * Just like object destructuring in JavaScript

  @impl true
  def handle_event("load-more", _, %{assigns: assigns} = socket) do
    {:noreply, assign(socket, page: assigns.page + 1) |> get_images()}
  end

  defp get_images(%{assigns: %{page: page}} = socket) do
    socket
    |> assign(page: page)
    |> assign(images: images())
  end

  defp images do
    url = "https://images.pexels.com/photos/"
    query = "?auto=compress&cs=tinysrgbg&w=600"

    ~W(
      2880507 13046522 13076228 13350109 13302244 12883181
      12977343 13180599 12059441 6431576 10651558 5507243
      13386712 13290875 13392891 13156418 8581056 13330222
      10060916 8064098
    )
    |> Enum.map(&"#{url}#{&1}/pexels-photo-#{&1}.webp#{query}")
    |> Enum.shuffle()
  end
end
