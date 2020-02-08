package com.lemartret.system_notifications

import android.annotation.TargetApi
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import androidx.annotation.NonNull
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

public class SystemNotificationsPlugin: FlutterPlugin, MethodCallHandler {
  private var kMethodChannel: String = "system_notifications"
  private lateinit var _channel: MethodChannel
  private lateinit var _appContext: Context

  private fun onAttachedToEngine(context: Context, binaryMessenger: BinaryMessenger) {
    _appContext = context
    _channel = MethodChannel(binaryMessenger, kMethodChannel)
    _channel.setMethodCallHandler(this)
    createChannel()
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    onAttachedToEngine(flutterPluginBinding.applicationContext, flutterPluginBinding.binaryMessenger)
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  // TODO: Test for retro compatibility
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      SystemNotificationsPlugin().onAttachedToEngine(registrar.context(), registrar.messenger())
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "makeNotification" -> makeNotification(call.argument("id"), call.argument("title"), call.argument("content"), call.argument("dismissible"))
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
  }

  private fun makeNotification(id: Int?, title: String?, content: String?, dismissible: Boolean?) {
    var builder = NotificationCompat.Builder(_appContext, kMethodChannel)
            .setSmallIcon(android.R.drawable.ic_menu_my_calendar)
            .setContentTitle(title)
            .setContentText(content)
            .setOngoing(!dismissible!!)
            .setOnlyAlertOnce(true)
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)

    val notification: Notification = builder.build()
    val notificationManagerCompat: NotificationManagerCompat? = getNotificationManager(_appContext)
    notificationManagerCompat!!.notify(id!!, notification)
  }

  private fun getNotificationManager(context: Context): NotificationManagerCompat? {
    return NotificationManagerCompat.from(context)
  }

  // TODO: Export Channel Creation
  @TargetApi(Build.VERSION_CODES.O)
  private fun createChannel() {
    val mNotificationManager = _appContext
            .getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
    val id = kMethodChannel
    val name: CharSequence = "Push Notification"
    val description = "Push Notification"
    val importance = NotificationManager.IMPORTANCE_HIGH
    val mChannel = NotificationChannel(id, name, importance)
    mChannel.description = description
    mChannel.setShowBadge(false)
    mChannel.lockscreenVisibility = Notification.VISIBILITY_PUBLIC
    mNotificationManager.createNotificationChannel(mChannel)
  }
}
