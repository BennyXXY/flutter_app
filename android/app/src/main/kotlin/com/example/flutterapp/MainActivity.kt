package com.example.flutterapp

import io.flutter.app.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {

//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//        GeneratedPluginRegistrant.registerWith()
//        FlutterPlugins.registerWith(registrarFor(FlutterPlugins::class.java.name))
//    }

    fun configureFlutterEngine(flutterEngine: FlutterEngine?) {
        GeneratedPluginRegistrant.registerWith(flutterEngine!!)
    }
}
