package com.ns.control

import com.ns.model.Person
import javafx.collections.ObservableList
import tornadofx.*

class MyController : Controller() {
    val api: Rest by inject()

    fun fetcthPeople(): ObservableList<Person>  =
            api.get("astros.json").one().getJsonArray("people").toModel()
}
