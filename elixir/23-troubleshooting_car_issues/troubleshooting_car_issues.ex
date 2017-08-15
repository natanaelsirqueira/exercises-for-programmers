Code.load_file("../util/input.ex")

defmodule Question do
  defstruct [:text, :yes, :no]
end

defmodule Answer do
  defstruct [:text]
end

defmodule TroubleshootingCarIssues do
  import Input

  @decision_tree %Question{
    text: "Is the car silent when you turn the key?",
    yes: %Question{
      text: "Are the battery terminals corroded?",
      yes: %Answer{text: "Clean terminals and try starting again."},
      no: %Answer{text: "Replace cables and try again."}
    },
    no: %Question{
      text: "Does the car make a clicking noise?",
      yes: %Answer{text: "Replace the battery."},
      no: %Question{
        text: "Does the car crank up but fail to start?",
        yes: %Answer{text: "Check spark plug connections."},
        no: %Question{
          text: "Does the engine start and then die?",
          yes: %Question{
            text: "Does your car have fuel injection?",
            yes: %Answer{text: "Get it in for service."},
            no: %Answer{text: "Check to ensure the choke is opening and closing."},
          },
        }
      },
    }
  }

  def run do
    IO.puts run_decision_tree(@decision_tree)
  end

  def run_decision_tree(%Question{} = question) do
    input = string(question.text <> " ")

    if input == "y" do
      run_decision_tree(question.yes)
    else
      run_decision_tree(question.no)
    end
  end

  def run_decision_tree(%Answer{text: text}), do: text
end

TroubleshootingCarIssues.run()
