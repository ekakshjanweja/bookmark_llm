import 'package:flutter/material.dart';

class NotificationRedirectPage extends StatelessWidget {
  static const String routeName = "/notification-redirect-page";

  final String title;
  const NotificationRedirectPage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(title),
      ),
    );
  }
}
