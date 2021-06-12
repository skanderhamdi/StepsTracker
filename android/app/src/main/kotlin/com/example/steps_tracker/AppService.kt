package com.nyartech.flutter.steps_tracker

import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.Build
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.widget.Toast
import androidx.core.app.NotificationCompat
import com.example.steps_tracker.SharedPreferencesManager
import io.flutter.Log
import java.util.*

class AppService : Service(), SensorEventListener {

    private var isStarted = false
    private var sensorManager: SensorManager? = null
    private var stepCounter = 0
    private var counterSteps = 0
    private var stepDetector = 0
    private var startDate: Date? = null
    private var endDate: Date? = null

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
        Log.d("MethodChannel", "accuracy = $accuracy")
    }

    override fun onSensorChanged(event: SensorEvent?) {

        Log.d("onSensorChanged", "fired = ${event!!.values[0]}")
        when (event!!.sensor.type) {
            Sensor.TYPE_STEP_DETECTOR -> {
                stepDetector++
            }
            Sensor.TYPE_STEP_COUNTER -> {
                if (counterSteps < 1) {
                    counterSteps = event.values[0].toInt()
                    SharedPreferencesManager.instance.saveInitialStepCount(counterSteps)
                }
                stepCounter = event.values[0].toInt() - counterSteps
            }
        }
        //showToast("step counter = $stepCounter")

    }


    val ACTION_START_FOREGROUND_SERVICE = "ACTION_START_FOREGROUND_SERVICE"
    val ACTION_STOP_FOREGROUND_SERVICE = "ACTION_STOP_FOREGROUND_SERVICE"

    override fun onCreate() {
        super.onCreate()
    }

    lateinit var intent: Intent
    lateinit var appContext: Context

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {

        Log.d("onStartCommand","onStartCommand called")

        appContext = baseContext
        sensorManager = appContext?.getSystemService(Context.SENSOR_SERVICE) as SensorManager
        startDate = SharedPreferencesManager.instance.loadStartDate()
        counterSteps = SharedPreferencesManager.instance.loadInitialStepCount()
        Log.d("MethodChannel", "startDate = $startDate")
        Log.d("MethodChannel", "counterSteps = $counterSteps")
        if (startDate != null) {
            isStarted = true
        }
        val bundle = intent!!.getExtras()

        when(intent.action)
        {
            ACTION_START_FOREGROUND_SERVICE -> {
                if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
                {
                    val stopSelf = Intent(this, AppService::class.java)
                    stopSelf.setAction(this.ACTION_STOP_FOREGROUND_SERVICE)
                    val pStopSelf = PendingIntent.getService(this, 0, stopSelf, PendingIntent.FLAG_CANCEL_CURRENT)
                    val stopServiceAction = NotificationCompat.Action(
                            android.R.drawable.ic_menu_close_clear_cancel,
                            "Stop Service",
                            pStopSelf
                    )
                    val notificationBuilder = NotificationCompat.Builder(this,"st_service")
                            .setContentText(bundle!!.get("subTitle").toString())
                            .setContentTitle(bundle!!.get("title").toString())
                            .setContentInfo(bundle!!.get("subText").toString())
                            .addAction(stopServiceAction)
                            .setSmallIcon(R.mipmap.app_logo)
                            .build()
                    Log.d("onStartCommand","Starting Foreground Service...")
                    startForeground((System.currentTimeMillis()%10000).toInt(),notificationBuilder)
                    Log.d("onStartCommand","Foreground Service Started!")
                }
                startService()
            }
            ACTION_STOP_FOREGROUND_SERVICE -> {
                stopForeground(true)
                stopSelf()
            }
            else -> {
                Log.d("onStartCommand","onStartCommand could not find action name.")
                startService()
            }
        }
        Log.d("onStartCommand","finished!")
        return START_STICKY
    }

    fun startService()
    {
        Log.d("startService","startService called")
        val stepsSensor = sensorManager?.getDefaultSensor(Sensor.TYPE_STEP_COUNTER)

        if (stepsSensor == null) {
            Toast.makeText(appContext, "No Step Counter Sensor !", Toast.LENGTH_SHORT).show()
        } else {
            sensorManager?.registerListener(this, stepsSensor, SensorManager.SENSOR_DELAY_FASTEST)
        }
    }

    override fun stopService(name: Intent?): Boolean {
        Log.d("AppService","Stopping AppService...")
        sensorManager?.unregisterListener(this)
        SharedPreferencesManager.instance.clear()
        return super.stopService(name)
    }

    override fun onBind(intent: Intent?): IBinder? {
        Log.d("onBind","onBind called")
        return null;
    }

    override fun onRebind(intent: Intent?) {
        Log.d("onRebind","onRebind called")
    }

    override fun onDestroy() {
        Log.d("onDestroy","onDestroy called")
        super.onDestroy()
    }

    fun showToast(message: String) {
        val handler = Handler(Looper.getMainLooper())
        handler.post(Runnable { Toast.makeText(appContext, message, Toast.LENGTH_LONG).show() })
    }

}