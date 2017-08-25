string = input("What is the input string? ").strip()
l = len(string)
print(f"{string} has {l} character{'s' if l > 1 else ''}." if l > 0 else "You must enter something.")
