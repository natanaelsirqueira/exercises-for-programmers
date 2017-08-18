package com.ns.inspace.view

import com.ns.inspace.control.MyController
import com.ns.inspace.model.Person
import tornadofx.*

class MainView : View("People in Space") {
    private val myController: MyController by inject()
    private val persons = myController.fetchPeople()

    override val root = tableview(persons) {
        column("Name", Person::name)
        column("Craft", Person::craft)
        columnResizePolicy = SmartResize.POLICY
    }
}
