defmodule Employees.Records do
  alias Employees.TableFormatter

  defmodule State do
    defstruct [sort_by: "Employee Id", filter_by: nil, records: [], only_past_six_months: false]
  end

  def run do
    init(%State{})
  end

  def conn do
    {:ok, conn} = Redix.start_link()

    conn
  end

  def list(state) do
    conn = conn()
    records =
      conn
      |> get_all()
      |> Enum.map(&get(conn, &1))
      |> Enum.map(&create_map(&1, %{}))

    %{state | records: records}
  end

  def init(state) do
    render(state)

    """

    Choose an action
    LF - Load from file.
    LD - Load from database.
    S  - Sort records by a given field.
    F  - Filter records by a given search string (position included).
    SD - Toggle show only employees where their separation date is six months ago or more.
    R  - Reset to default visualization.
    Your action: \
    """
    |> string()
    |> String.upcase
    |> action(state)
    |> init()
  end

  def render(state) do
    state.records
    |> only_past_six_months(state.only_past_six_months)
    |> sort_by(state.sort_by)
    |> filter_by(state.filter_by)
    |> print_table()
  end

  def action("LF", state), do: load_file(state)

  def action("LD", state), do: list(state)

  def action("S", state) do
    sort_field = string("Sort data by: ")

    %{state | sort_by: sort_field}
  end

  def action("F", state) do
    search_string = string("Enter a search string: ")

    %{state | filter_by: (if search_string == "", do: nil, else: search_string)}
  end

  def action("SD", state), do: Map.update!(state, :only_past_six_months, &not/1)

  def action("R" , state), do: %{state | sort_by: "Employee Id", filter_by: nil}

  def print_table(records) do
    TableFormatter.print_table_for_columns(records,
      ["Employee Id", "First Name", "Last Name", "Position", "Separation Date"])
  end

  def sort_by(records, sort_field) do
    sort_field =
      sort_field
      |> String.split
      |> Enum.map(&String.capitalize(&1))
      |> Enum.join(" ")

    Enum.sort_by(records, fn employee -> employee[sort_field] end)
  end

  def filter_by(records, nil), do: records
  def filter_by(records, search_string) do
    search_string = String.downcase(search_string)
    Enum.filter(records, fn employee ->
      Map.keys(employee)
      |> Enum.map(&employee[&1])
      |> Enum.any?(fn field ->
        String.downcase(field) =~ search_string
      end)
    end)
  end

  def only_past_six_months(records, false), do: records
  def only_past_six_months(records, true) do
    six_months_ago =
      Date.utc_today
      |> Date.add(6 * 30 * -1)

    records
    |> Stream.reject(&(&1["Separation Date"] == "--"))
    |> Enum.filter(fn record ->
      record["Separation Date"]
      |> Date.from_iso8601!()
      |> Date.compare(six_months_ago) == :lt
    end)
  end

  def load_file(state) do
    conn = conn()
    Enum.each(read_from_file(), &insert(conn, &1))

    list(state)
  end

  def read_from_file do
    [header | body] =
      File.read!("lib/employees/records.txt")
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, ","))

    Enum.map(body, &Enum.zip(header, &1) |> Enum.into(%{}))
  end

  def insert(conn, params) do
    Redix.pipeline(conn,
      [["HMSET", "employees:#{params["Employee Id"]}",
        "employee_id",     params["Employee Id"],
        "first_name",      params["First Name"],
        "last_name",       params["Last Name"],
        "position",        params["Position"],
        "separation_date", params["Separation Date"]]])
  end

  def flush(conn), do: delete(conn, "employees:*")

  defp string(prompt) do
    IO.gets(prompt) |> String.trim
  end

  defp get_all(conn) do
    {:ok, keys} = Redix.command(conn, ~w[KEYS employees:*])

    keys
  end

  defp get(conn, employee) do
    {:ok, keys} = Redix.command(conn, ["HGETALL", employee])

    keys
  end

  defp create_map([], acc), do: acc
  defp create_map([ k , v | t ], acc) do
    k = String.split(k, "_") |> Enum.map(&String.capitalize(&1)) |> Enum.join(" ")
    acc = Map.put(acc, k, v)

    create_map(t, acc)
  end

  defp delete(conn, pattern) do
    lua = """
      local count = 0

      for _, k in ipairs(redis.call('keys', ARGV[1])) do
        count = count + 1
        redis.call('DEL', k)
      end

      return count
    """

    Redix.command(conn, ["EVAL", lua, "0", pattern])
  end
end
