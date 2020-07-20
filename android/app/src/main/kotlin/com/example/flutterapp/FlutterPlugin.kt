package com.example.flutterapp

import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class FlutterPlugins : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel

    //此处插件必须为插件工程，否则不可调用

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "chennl_t_D")
        channel.setMethodCallHandler(this);
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null);
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "chennl_t_D")
            channel.setMethodCallHandler(FlutterPlugins())
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Log.e("FlutterPlugins","ssssssss:${call.method}")
        if (call.method == "getA") {
            result.success("XinXy: ${199407}");
        } else {
            result.notImplemented();
        }
    }
}