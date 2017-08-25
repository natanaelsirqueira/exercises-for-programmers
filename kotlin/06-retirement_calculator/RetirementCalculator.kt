import Input.positiveInt
import java.time.LocalDate

fun main(args: Array<String>) {
    val age = positiveInt("What is your current age? ")
    val retirementAge = positiveInt("At what age would you like to retire? ")

    println(result(retirementAge - age))
}

fun result(timeUntilRetire: Int): String {
    val currentYear = LocalDate.now().year

    return if (timeUntilRetire > 0) {
        """You have $timeUntilRetire year(s) left until you can retire.
            |It's $currentYear, so you can retire in ${currentYear + timeUntilRetire}.""".trimMargin()
    }
    else
        "You can already retire."
}
