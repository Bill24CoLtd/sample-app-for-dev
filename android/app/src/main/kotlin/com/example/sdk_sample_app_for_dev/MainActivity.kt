package com.example.sdk_sample_app_for_dev

import io.flutter.embedding.android.FlutterActivity

import io.flutter.embedding.engine.FlutterEngine

import io.flutter.plugin.common.MethodChannel
import java.util.*
import com.bill24.paymentSdk.paymentSdk

import io.flutter.embedding.android.FlutterFragmentActivity
import java.lang.Exception


class MainActivity: FlutterFragmentActivity() {
    private val CHANNEL = "paymentSdk"
    private lateinit var channel: MethodChannel


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val methodChannel: MethodChannel =
            MethodChannel(flutterEngine.dartExecutor.binaryMessenger,
                "paymentSdk")
        methodChannel.setMethodCallHandler { call, result ->
            if(call.method == "paymentSdk") {
                val sdk_parameters = call.arguments as Map<String, String>
                val paymentSdk = paymentSdk(
                    supportFragmentManager = supportFragmentManager,
                    sessionId = sdk_parameters["session_id"].toString(),
                    client_id = sdk_parameters["client_id"].toString(),
                    activity = this@MainActivity,
                    language = sdk_parameters["language"].toString(),
                    environment = sdk_parameters["environment"].toString())
                {
                    // return result to Flutter
                    result.success(it.toString())
                }

                // Show SDK screen
                paymentSdk.show(supportFragmentManager,"")
            }
        }
    }
}
