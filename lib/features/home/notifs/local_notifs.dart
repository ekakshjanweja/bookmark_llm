import 'dart:developer' as dev;

import 'package:awesome_notifications/awesome_notifications.dart';

class LocalNotifs {
  static final AwesomeNotifications awesomeNotifications =
      AwesomeNotifications();

  static final List<NotificationChannel> _channels = [
    NotificationChannel(
      channelKey: "test_channel",
      channelName: "Test Channel",
      channelDescription: "Channel to test out notifications",
      importance: NotificationImportance.Max,
    ),
    NotificationChannel(
      channelKey: "scheduled",
      channelName: "scheduled_channel",
      channelDescription: "Channel to test out scheduled notifications",
      importance: NotificationImportance.Max,
    ),
  ];

  static List<NotificationChannel> get channels => _channels;

  static Future<void> init() async {
    await awesomeNotifications.initialize(
      null,
      _channels,
    );

    await awesomeNotifications.resetGlobalBadge();
    awesomeNotifications.setListeners(
      onActionReceivedMethod: NotifController.onActionReceivedMethod,
      onNotificationCreatedMethod: NotifController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotifController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotifController.onDismissActionReceivedMethod,
    );
  }

  static Future<void> showNotif(
    NotificationChannel? channel, {
    String? title,
    String? body,
    required int id,
  }) async {
    final NotificationChannel notificationChannel = channel ?? _channels.first;

    await awesomeNotifications.createNotification(
      content: NotificationContent(
        id: id,
        channelKey: notificationChannel.channelKey!,
        title: title,
        body: body,
        wakeUpScreen: true,
      ),
    );
  }

  static Future<void> showScheduleNotif() async {
    String localTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();
    String utcTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();
    final Object notificationChannel = channels ?? _channels.first;

    await awesomeNotifications.createNotification(
      content: NotificationContent(
        id: 233232121,
        channelKey: 'scheduled',
        title: 'Notification every minute.',
        body: 'This notification was scheduled to repeat every minute. fgsgrsg',
        wakeUpScreen: true,
      ),
      // schedule: NotificationInterval(
      //   interval: 60,
      //   timeZone: localTimeZone,
      //   repeats: true,
      // ),

      schedule: NotificationCalendar(
        year: 2024,
        month: 6,
        day: 13,
        hour: 16,
        minute: 24,
        second: 00,
        timeZone: localTimeZone,
        repeats: true,
      ),
    );
  }
}

class NotifController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
    dev.log('Notification created: ${receivedNotification.id}');
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
    dev.log('Notification displayed: ${receivedNotification.id}');
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
    dev.log('Notification dismissed: ${receivedAction.id}');
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
    dev.log('Action received: ${receivedAction.id}');
    // Navigate into pages, avoiding to open the notification details page over another details page already opened
  }
}
