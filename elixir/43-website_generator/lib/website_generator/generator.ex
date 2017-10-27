defmodule WebsiteGenerator.Generator do
  @moduledoc """
  Module responsible for creating the website skeleton based on the given params.
  """

  @doc """
  Creates a ZIP file in memory containing the files for the website.
  """
  def generate(params) do
    root = params.site_name

    files =
      [{'#{root}/index.html', build_html_content(params.site_name, params.author)}]
      |> maybe_create_css(root)
      |> maybe_create_js(root)

    with {:ok, zip_file} <- :zip.create('#{root}.zip', files) do
      {:ok, to_string(zip_file)}
    end
  end

  defp maybe_create_css(files, %{css: false}), do: files
  defp maybe_create_css(files, root), do: [{'#{root}/css/style.css', ""} | files]

  defp maybe_create_js(files, %{js: false}), do: files
  defp maybe_create_js(files, root), do: [{'#{root}/js/script.js', ""} | files]

  defp build_html_content(site_name, author) do
    """
    <!DOCTYPE html>
    <html>
      <head>
        <meta charset="utf-8">
        <meta author="#{author}">
        <title>#{site_name}</title>
      </head>
      <body>
        <h1>Welcome to #{site_name}!</h1>
      </body>
    </html>
    """
  end
end
