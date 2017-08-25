def read_int(prompt):
    s = ""
    while not isnumber(s):
        s = input(prompt)

    return int(s)

def isnumber(s):
    try:
        int(s)
        return True
    except ValueError:
        return False

a = read_int("Enter the first number: ")
b = read_int("Enter the second number: ")

print(f"{a} + {b} = {a + b}")
print(f"{a} - {b} = {a - b}")
print(f"{a} * {b} = {a * b}")
print(f"{a} / {b} = {a / b}")
