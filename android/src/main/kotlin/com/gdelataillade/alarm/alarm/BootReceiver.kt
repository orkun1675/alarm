package com.gdelataillade.alarm.alarm

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import com.gdelataillade.alarm.services.AlarmStorage
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class BootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == Intent.ACTION_BOOT_COMPLETED) {
            Log.d("BootReceiver", "Device rebooted, rescheduling alarms")

            rescheduleAlarms(context)
        }
    }

    private fun rescheduleAlarms(context: Context) {
        val alarmStorage = AlarmStorage(context)
        val storedAlarms = alarmStorage.getSavedAlarms()
    
        Log.d("BootReceiver", "Rescheduling ${storedAlarms.size} alarms")
    
        for (alarm in storedAlarms) {
            var alarmArgs: Map<String, Any>? = null
    
            try {
                // Create the arguments for the MethodCall
                alarmArgs = mapOf(
                    "id" to alarm.id,
                    "dateTime" to alarm.dateTime.time,
                    "assetAudioPath" to alarm.assetAudioPath,
                    "loopAudio" to alarm.loopAudio,
                    "vibrate" to alarm.vibrate,
                    "fadeDuration" to alarm.fadeDuration,
                    "fadeStopTimes" to alarm.fadeStopTimes,
                    "fadeStopVolumes" to alarm.fadeStopVolumes,
                    "fullScreenIntent" to alarm.androidFullScreenIntent,
                    "notificationSettings" to mapOf(
                        "title" to alarm.notificationSettings.title,
                        "body" to alarm.notificationSettings.body,
                        "stopButton" to alarm.notificationSettings.stopButton,
                        "icon" to alarm.notificationSettings.icon
                    )
                ).toMutableMap()
    
                alarm.volume?.let {
                    alarmArgs[ "volume" ] = it
                }
    
                Log.d("BootReceiver", "Rescheduling alarm with ID: ${alarm.id}")
                Log.d("BootReceiver", "Alarm arguments: $alarmArgs")
    
                // Simulate the MethodCall
                val methodCall = MethodCall("setAlarm", alarmArgs)
    
                // Call the setAlarm method in AlarmPlugin with the custom context
                val alarmPlugin = AlarmPlugin()
                alarmPlugin.setAlarm(methodCall, object : MethodChannel.Result {
                    override fun success(result: Any?) {
                        Log.d("BootReceiver", "Alarm rescheduled successfully for ID: ${alarm.id}")
                    }
    
                    override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                        Log.e("BootReceiver", "Failed to reschedule alarm for ID: ${alarm.id}, Error: $errorMessage")
                    }
    
                    override fun notImplemented() {
                        Log.e("BootReceiver", "Method not implemented")
                    }
                }, context)
            } catch (e: Exception) {
                Log.e("BootReceiver", "Exception while rescheduling alarm with arguments: $alarmArgs", e)
            }
        }
    }
}