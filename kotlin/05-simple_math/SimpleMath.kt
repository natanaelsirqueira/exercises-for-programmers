import Input.int

fun main(args: Array<String>) {
    val a = int("What is the first number? ")
    val b = int("What is the second number? ")

    printOperations(a, b)
}

fun printOperations(a: Int, b: Int) {
    println("$a + $b = ${a + b}\n" +
            "$a - $b = ${a - b}\n" +
            "$a * $b = ${a * b}\n" +
            "$a / $b = ${a / b}")
}
