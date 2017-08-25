import Input.string

fun print(quote: String, author: String) = println("$author says, \"$quote\"")

fun printList(quotes: Array<Pair<String, String>>) {
    quotes.forEach { print(it.second, it.first) }
}

fun main(args: Array<String>) {
    val quote = string("What is the quote? ")
    val author = string("Who said it? ")

    print(quote, author)

    val quotes = arrayOf(
            Pair("Obi-Wan Kenobi", "These aren't the droids you're looking for."),
            Pair("Darth Vader", "I find your lack of faith disturbing."),
            Pair("Yoda", "Do. Or do not. There is no try.")
    )

    printList(quotes)
}
