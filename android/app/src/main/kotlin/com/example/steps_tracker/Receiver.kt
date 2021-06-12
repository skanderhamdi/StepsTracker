package com.nyartech.flutter.steps_tracker

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import io.flutter.Log

class Receiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {
        Log.i("Service Stops", "Ohhhhhhh")
        context.startService(Intent(context, AppService::class.java))
    }

}