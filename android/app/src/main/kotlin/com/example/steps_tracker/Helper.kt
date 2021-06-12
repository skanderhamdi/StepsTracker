package com.example.steps_tracker

import android.content.Context
import android.content.SharedPreferences
import java.text.SimpleDateFormat
import java.util.*

class SharedPreferencesManager {

    companion object {
        val instance = SharedPreferencesManager()
    }

    private val kPrivateMode = 0
    private val kPerfName = "step_counter"
    private val kStartDate = "start_date"
    private val kInitialStepCount = "initial_step_count"
    private lateinit var sharedPref: SharedPreferences

    fun init(context: Context) {
        sharedPref = context.getSharedPreferences(kPerfName, kPrivateMode)
    }

    fun saveStartDate(date: Date) {
        val editor:SharedPreferences.Editor =  sharedPref.edit()
        editor.putLong(kStartDate, date.time)
    }

    fun loadStartDate(): Date? {
        val time = sharedPref.getLong(kStartDate, 0L)
        if (time != 0L) {
            return Date(time)
        }
        return null
    }

    fun saveInitialStepCount(step: Int) {
        val editor:SharedPreferences.Editor =  sharedPref.edit()
        editor.putInt(kInitialStepCount, step)
    }

    fun loadInitialStepCount(): Int {
        return sharedPref.getInt(kInitialStepCount, 0)
    }

    fun clear() {
        val editor:SharedPreferences.Editor =  sharedPref.edit()
        editor.clear()
    }
}

object AppUtils {

    fun getFormattedDate(date: Date): String {
        val sdf = SimpleDateFormat("yyyy-M-dd HH:mm:ss", Locale.TAIWAN)
        return sdf.format(date)
    }

}