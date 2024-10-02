package com.yashjha.native_notification_handler.native_notification_handler

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** NativeNotificationHandlerPlugin */
class NativeNotificationHandlerPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "native_notification_handler")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }

            "createNotificationChannel" -> {
                val channelId = call.argument<String>("channelId") ?: ""
                val channelName = call.argument<String>("channelName") ?: ""
                val channelDescription = call.argument<String>("channelDescription") ?: ""
                createNotificationChannel(channelId, channelName, channelDescription)
                result.success(null)
            }

            "showNotification" -> {
                val id = call.argument<Int>("id") ?: 0
                val title = call.argument<String>("title") ?: ""
                val body = call.argument<String>("body") ?: ""
                showNotification(id, title, body)
                result.success(null)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun createNotificationChannel(
        channelId: String,
        channelName: String,
        channelDescription: String
    ) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val channel = NotificationChannel(channelId, channelName, importance).apply {
                description = channelDescription
            }
            val notificationManager: NotificationManager =
                context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }

    private fun showNotification(id: Int, title: String, body: String) {
        val intent = Intent(context, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        }
        val pendingIntent: PendingIntent =
            PendingIntent.getActivity(context, 0, intent, PendingIntent.FLAG_IMMUTABLE)

        val builder = Notification.Builder(context, "channel_id")
            .setSmallIcon(R.drawable.notification_icon) // Replace with your notification icon
            .setContentTitle(title)
            .setContentText(body)
            .setPriority(Notification.PRIORITY_DEFAULT)
            .setContentIntent(pendingIntent)
            .setAutoCancel(true)

        with(context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager) {
            notify(id, builder.build())
        }
    }
}
