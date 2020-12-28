defmodule Floki do

  @index_page "https://elixircastsio.github.io/record-store/"

  def write_seller_info do
    case fetch_html(@index_page) do
      {:ok, html} ->
        #get links, parse info
        html
        |> album_links()
        |> Stream.map(&fetch_html/1)
      {:error, msg} ->
        msg
    end
  end

  defp format_seller_info(html) do
    case html do
      {:ok, body} ->
        # some code
      {:error, msg} ->
        msg
    end
  end

  defp album_links(html) do
    html
    |> Floki.find(".table tr a")
    |> Floki.attribute("href")
  end

  defp fetch_html(url) do
    case HTTPoison.get(url) do
      {:ok, response} ->
        {:ok, response.body}
      {:error, _error} ->
        {:error, "There was an issue fetching #{url}"}
    end
  end
end
