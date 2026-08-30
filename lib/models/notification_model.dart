import 'package:flutter/cupertino.dart';

class NotificationModel {
  final String title;
  final String message;
  final IconData? icon;
  final DateTime date;
  final VoidCallback? onTap;

  NotificationModel(
      {required this.title,
      required this.message,
      this.icon,
      required this.date,
      this.onTap});
}
