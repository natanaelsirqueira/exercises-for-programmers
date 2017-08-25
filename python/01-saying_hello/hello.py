name = input("What is your name? ").strip()
print(f'Hello, {name}, nice to meet you!' if len(name) > 0 else "You must enter something.")
