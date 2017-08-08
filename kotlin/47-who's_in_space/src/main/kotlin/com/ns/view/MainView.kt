package com.ns.view

import com.ns.control.MyController
import com.ns.model.Person
import tornadofx.*

class MainView : View("People in Space") {
    val myController: MyController by inject()
    private val persons = myController.fetcthPeople()

    override val root = tableview(persons) {
        column("Name", Person::name)
        column("Craft", Person::craft)
        columnResizePolicy = SmartResize.POLICY
    }
}
