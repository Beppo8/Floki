defmodule Floki do

  @index_page "https://elixircastsio.github.io/record-store/"

  def write_seller_info do
    case fetch_html(@index_page) do
      {:ok, html} ->
        #get links, parse info
      {:error, msg} ->
        msg
    end
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
