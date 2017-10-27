defmodule WebsiteGeneratorWeb.GeneratorControllerTest do
  use WebsiteGeneratorWeb.ConnCase

  describe "POST /generate" do
    test "creates the zip with the website skeleton based on the values entered by the user", %{conn: conn} do
      params = %{site_name: "mysite", author: "me", js: true, css: true}

      assert zip_file =
        conn
        |> post("/generate", %{"site" => params})
        |> response(:ok)

      with {:ok, handle} <- :zip.zip_open(zip_file) do
        {:ok, files} = :zip.zip_get(handle)
        :zip.zip_close(handle)

        assert files == ['mysite/js/script.js', 'mysite/css/style.css', 'mysite/index.html']
      end

      File.rm("#{params.site_name}.zip")
      File.rm_rf(params.site_name)
    end
  end
end
