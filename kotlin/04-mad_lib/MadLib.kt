import Input.string

fun main(args: Array<String>) {
    val noun = string("Enter a noun: ")
    val verb = string("Enter a verb: ")
    val adjective = string("Enter an adjective: ")
    val adverb = string("Enter an adverb: ")

    println("Do you $verb your $adjective $noun $adverb? That's hilarious!")
}
