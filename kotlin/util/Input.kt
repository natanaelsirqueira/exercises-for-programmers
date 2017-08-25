interface Parsable {
    fun parse(string: String): Any
}

enum class Type : Parsable {
    INT { override fun parse(string: String): Any = string.toInt() },
    FLOAT { override fun parse(string: String): Any = string.toFloat() },
    DOUBLE { override fun parse(string: String): Any = string.toDouble() }
}

object Input {

    fun string(prompt: String): String {
        print(prompt)
        val input = readLine()!!

        if (input.trim().isEmpty())
            error("You must enter something.")

        return input
    }

    fun int(prompt: String): Int = number(prompt, Type.INT) as Int
    fun float(prompt: String): Float = number(prompt, Type.FLOAT) as Float
    fun double(prompt: String): Double = number(prompt, Type.DOUBLE) as Double

    fun positiveInt(prompt: String): Int = positiveNumber(prompt, Type.INT) as Int
    fun positiveFloat(prompt: String): Float = positiveNumber(prompt, Type.FLOAT) as Float
    fun positiveDouble(prompt: String): Double = positiveNumber(prompt, Type.DOUBLE) as Double

    private fun number(prompt: String, type: Type): Any {
        val input = string(prompt)

        if (!isNumeric(input))
            error("You must enter a number.")

        return type.parse(input)
    }

    private fun positiveNumber(prompt: String, type: Type): Any {
        val number = number(prompt, type)

        if (number < 0)
            error("You must enter a positive number.")

        return number
    }

    private fun isNumeric(input: String): Boolean {
        return try {
            input.toDouble()
            true
        } catch (e: NumberFormatException) {
            false
        }
    }

    private fun error(message: String) {
        System.err.println(message)
        System.exit(1)
    }
}

private operator fun Any.compareTo(other: Number): Int {
    val num = this.toString().toDouble()
    val n = other.toDouble()

    return when {
        num > n -> 1
        num < n -> -1
        else -> 0
    }
}
