import datetime
import textwrap

def print_result(time_until_retire):
    current_year = datetime.date.today().year

    if time_until_retire > 0:
        print(textwrap.dedent(
            f"""\
            You have {time_until_retire} years left until you can retire.
            It's {current_year}, so you can retire in {current_year + time_until_retire}.
            """))
    else:
        print("You can already retire.")

age = int(input("What is your current age? "))
retirement_age = int(input("What age would you like to retire? "))

print_result(retirement_age - age)
