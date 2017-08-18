package com.ns.inspace.control

import com.ns.inspace.model.Person
import javafx.collections.ObservableList
import tornadofx.*

class MyController : Controller() {
    private val api: Rest by inject()

    fun fetchPeople(): ObservableList<Person> =
            api.get("astros.json").one().getJsonArray("people").toModel()
}
