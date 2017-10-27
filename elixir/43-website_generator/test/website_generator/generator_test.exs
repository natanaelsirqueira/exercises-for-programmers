defmodule WebsiteGenerator.GeneratorTest do
  use WebsiteGeneratorWeb.ConnCase

  alias WebsiteGenerator.Generator

  test "creates a zip with the site structure based on the values entered by the user" do
    params = %{site_name: "mysite", author: "me", js: true, css: true}

    assert {:ok, zip_file} = Generator.generate(params)

    {:ok, handle} = zip_file |> to_charlist |> :zip.zip_open
    {:ok, files} = :zip.zip_get(handle)
    :zip.zip_close(handle)

    files = Enum.map(files, &to_string/1)

    root = params.site_name
    skeleton = ["#{root}/index.html", "#{root}/css/style.css", "#{root}/js/script.js"]

    assert Enum.all?(skeleton, &(&1 in files))

    index = File.read!("#{root}/index.html")
    assert String.contains?(index, params.author)
    assert String.contains?(index, params.site_name)

    File.rm("#{root}.zip")
    File.rm_rf(root)
  end
end
