package com.ns.inspace.app

import com.ns.inspace.view.MainView
import javafx.application.Application
import tornadofx.*

class MyApp: App(MainView::class, Styles::class) {
    private val api: Rest by inject()

    init {
        api.baseURI = "http://api.open-notify.org"
    }
}

fun main(args: Array<String>) {
    Application.launch(MyApp::class.java)
}
