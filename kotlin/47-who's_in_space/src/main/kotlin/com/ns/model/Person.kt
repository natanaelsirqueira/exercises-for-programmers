package com.ns.model

import tornadofx.*
import javax.json.JsonObject

class Person : JsonModel {
    var name by property<String>()
    fun nameProperty() = getProperty(Person::name)

    var craft by property<String>()
    fun craftProperty() = getProperty(Person::craft)

    override fun updateModel(json: JsonObject) {
        with(json) {
            name = string("name")
            craft = string("craft")
        }
    }

    override fun toJSON(json: JsonBuilder) {
        with(json) {
            add("name", name)
            add("craft", craft)
        }
    }
}
