package com.nyartech.flutter.steps_tracker

import android.app.Application
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import com.example.steps_tracker.SharedPreferencesManager

class App: Application()
{

    override fun onCreate() {
        super.onCreate()
        SharedPreferencesManager.instance.init(this)
        if(Build.VERSION.SDK_INT>=Build.VERSION_CODES.O)
        {
            val notificationChannel = NotificationChannel("st_service","Steps Tracker Service",NotificationManager.IMPORTANCE_HIGH)
            val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(notificationChannel)
        }
    }
}
