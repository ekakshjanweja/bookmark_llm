import 'dart:developer' as dev;
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bookmark_llm/core/routemaster_stuff.dart';
import 'package:bookmark_llm/features/home/pages/notification_redirect_page.dart';

class LocalNotifs {
  static final AwesomeNotifications awesomeNotifications =
      AwesomeNotifications();

  static final Map<String, NotificationChannel> _channels = {
    "test": NotificationChannel(
      channelKey: "test_channel",
      channelName: "Test Channel",
      channelDescription: "Channel to test out notifications",
      importance: NotificationImportance.Max,
    ),
    "scheduled": NotificationChannel(
      channelKey: "scheduled",
      channelName: "scheduled_channel",
      channelDescription: "Channel to test out scheduled notifications",
      importance: NotificationImportance.Max,
    ),
  };

  static Map<String, NotificationChannel> get channels => _channels;

  static Future<void> init() async {
    await awesomeNotifications.initialize(
      null,
      _channels.values.toList(),
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
    String? bigPicture,
    required int id,
  }) async {
    final NotificationChannel notificationChannel =
        channel ?? _channels["scheduled"] as NotificationChannel;

    await awesomeNotifications.createNotification(
      content: NotificationContent(
        id: id,
        channelKey: notificationChannel.channelKey!,
        title: title,
        body: body,
        wakeUpScreen: true,
        bigPicture: bigPicture,
        notificationLayout: NotificationLayout.BigPicture,
      ),
    );
  }

  static Future<void> showScheduleNotif({
    required int id,
    required DateTime scheduledDate,
  }) async {
    String utcTimeZone =
        await AwesomeNotifications().getUtcTimeZoneIdentifier();

    await awesomeNotifications.createNotification(
      content: NotificationContent(
        id: 233232121,
        channelKey: 'scheduled',
        title: 'Title of scheduled notification',
        body: 'Body of scheduled notification',
        wakeUpScreen: true,
      ),
      schedule: NotificationCalendar(
        year: scheduledDate.year,
        month: scheduledDate.month,
        day: scheduledDate.day,
        hour: scheduledDate.hour,
        minute: scheduledDate.minute,
        second: scheduledDate.second,
        timeZone: utcTimeZone,
        allowWhileIdle: true,
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
    if (receivedAction.channelKey == 'scheduled') {
      RoutemasterStuff.routemasterLoggedIn.push(
        NotificationRedirectPage.routeName,
        queryParameters: {
          "title": receivedAction.title ?? "Unknown title",
        },
      );
    }
  }
}

enum ScheduleNotifications {
  test1,
  test2,
  test3;

  int get id {
    switch (this) {
      case ScheduleNotifications.test1:
        return 1;
      case ScheduleNotifications.test2:
        return 2;
      case ScheduleNotifications.test3:
        return 3;
    }
  }
}
