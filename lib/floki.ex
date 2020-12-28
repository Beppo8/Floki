defmodule Floki do

  @index_page "https://elixircastsio.github.io/record-store/"

  def write_seller_info do
    file = File.stream!("seller-info.txt")

    case fetch_html(@index_page) do
      {:ok, html} ->
        html
        |> album_links()
        |> Stream.map(&fetch_html/1)
        |> Stream.map(&format_seller_info/1)
        |> Enum.into(file)
      {:error, msg} ->
        msg
    end
  end

  defp get_info(html_body, selector) do
    html_body
    |> Floki.find(selector)
    |> Floki.text()
    |> String.replace("\n", "")
  end

  defp format_seller_info(html) do
    case html do
      {:ok, body} ->
        "#{get_info(body, "album-title")}" <>
        "#{get_info(body, "seller-email")}" <>
        "#{get_info(body, "seller-phone")}\n"
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
