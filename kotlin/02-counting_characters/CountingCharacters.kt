import Input.string

fun main(args: Array<String>) {
    val str = string("What is the input string? ").trim()
    println("$str has ${str.length} characters.")
}
