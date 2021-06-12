package com.nyartech.flutter.steps_tracker

import android.content.Intent
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity(), MethodChannel.MethodCallHandler
{
    val ACTION_START_FOREGROUND_SERVICE = "ACTION_START_FOREGROUND_SERVICE"
    val ACTION_STOP_FOREGROUND_SERVICE = "ACTION_STOP_FOREGROUND_SERVICE"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        var channel  = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger,"foreground.service/steps_tracker_service")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        try {
            when (call.method)
            {
                "startService" -> {
                    val title: String? = call.argument("title")
                    val subTitle: String? = call.argument("subTitle")
                    val subText: String? = call.argument("subText")
                    startService(title,subTitle,subText)
                    result.success(true)
                }
                "stopService" -> {
                    stopService()
                    result.success(true)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }catch (e: Exception){
            //e.printStackTrace()
            result.error(e.message.toString(),"Error while calling starting service","MethodChannel Call Failed.")
        }
    }

    lateinit var intent:Any
    fun startService(title: String?,subTitle: String?, subText: String?)
    {
        intent = Intent(this,AppService::class.java)
        (intent as Intent).setAction(ACTION_START_FOREGROUND_SERVICE)
        (intent as Intent).putExtra("title",title)
        (intent as Intent).putExtra("subTitle",subTitle)
        (intent as Intent).putExtra("subText",subText)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(intent as Intent)
        }else
        {
            startService(intent as Intent)
        }
    }

    fun stopService()
    {
        stopService(intent as Intent)
    }

    override fun onDestroy()
    {
        super.onDestroy()
    }
}
