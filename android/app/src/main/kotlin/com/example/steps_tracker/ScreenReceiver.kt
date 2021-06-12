package com.nyartech.flutter.steps_tracker


import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent


class ScreenReceiver : BroadcastReceiver() {

    private var screenOff: Boolean = true

    override fun onReceive(context: Context, intent: Intent) {
        if (intent.getAction().equals(Intent.ACTION_SCREEN_OFF)) {
            screenOff = true
        } else if (intent.getAction().equals(Intent.ACTION_SCREEN_ON)) {
            screenOff = false
        }
        val i = Intent(context, AppService::class.java)
        i.putExtra("screen_state", screenOff)
        context.startService(i)
    }

}