def print_quote(quote, author):
    print(f'{author} says, "{quote}"')

def print_list(quotes):
    for elem in quotes:
        print(f"{elem['author']} says \"{elem['quote']}\"")

quote = input("What is the quote? ")
author = input("Who said it? ")

print_quote(quote, author)

quotes = [{'author': "Obi-Wan Kenobi", 'quote': "These aren't the droids you're looking for."},
          {'author': "Darth Vader", 'quote': "I find your lack of faith disturbing."},
          {'author': "Yoda", 'quote': "Do. Or do not. There is no try."}]

print_list(quotes)
