Code.load_file("../util/input.ex")

defmodule WordFinder do
  import Input

  def run do
    path = string("Enter the file/directory path: ")
    config_path = "config.conf"

    if File.exists?(path) do
      init(path, config(config_path))
    else
      IO.puts("There is no file or directory in that path.")
      run()
    end
  end

  def init(path, config) do
    new_path = string("Enter the new file/directory path: ")

    with {:ok, files_and_directories} <- File.cp_r(path, new_path) do
      replacements =
        files_and_directories
        |> Enum.reject(&File.dir?(&1))
        |> Enum.reduce(0, fn path, replacements ->
          find_and_replace(path, config) + replacements
        end)

      IO.puts("The new file(s) was/were saved in #{new_path}")
      IO.puts("#{replacements} replacement(s) was/were made.")
    end
  end

  defp config(config_path) do
    config_path
    |> File.read!()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn row -> String.split(row, ",") |> List.to_tuple() end)
  end

  defp find_and_replace(path, config) do
    words = File.read!(path) |> String.split(" ")
    {words, replacements} = replace_all(config, {words, 0})

    content = Enum.join(words, " ")
    File.write!(path, content)

    replacements
  end

  defp replace_all([], {words, replacements}), do: {words, replacements}

  defp replace_all([replace_params | config], {words, replacements}) do
    {new_words, new_replacements} = replace(replace_params, words)

    replace_all(config, {new_words, replacements + new_replacements})
  end

  defp replace({pattern, replacement}, words) do
    Enum.reduce(words, {[], 0}, fn word, {new_words, replacements} ->
      if word =~ pattern do
        word = String.replace(word, pattern, replacement, global: true)

        {[word | new_words], replacements + 1}
      else
        {[word | new_words], replacements}
      end
    end)
  end
end

WordFinder.run()
