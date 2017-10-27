defmodule WebsiteGeneratorWeb.GeneratorController do
  use WebsiteGeneratorWeb, :controller

  alias WebsiteGenerator.Generator
  alias Ecto.Changeset

  @types %{site_name: :string, author: :string, css: :boolean, js: :boolean}

  def index(conn, _params) do
    changeset = Changeset.change({%{}, @types}, %{})

    render(conn, "index.html", changeset: changeset)
  end

  def create(conn, %{"site" => params}) do
    changeset =
      {%{}, @types}
      |> Changeset.cast(params, Map.keys(@types))
      |> Changeset.validate_required(~w[site_name author]a)
      |> Changeset.validate_length(:site_name, min: 2)
      |> Changeset.validate_length(:author, min: 2)

    case Changeset.apply_action(changeset, :insert) do
      {:ok, data} ->
        {:ok, zip_file} = Generator.generate(data)

        try do
          send_download(conn, {:file, zip_file})
        after
          File.rm!(zip_file)
        end
      {:error, changeset} ->
        render(conn, "index.html", changeset: changeset)
    end
  end
end
