package com.ns.app

import com.ns.control.MyController
import com.ns.view.MainView
import javafx.application.Application
import tornadofx.*

class MyApp: App(MainView::class, Styles::class) {
    val api: Rest by inject()
    val myController: MyController by inject()

    init {
        api.baseURI = "http://api.open-notify.org"
    }
}

fun main(args: Array<String>) {
    Application.launch(MyApp::class.java)
}
