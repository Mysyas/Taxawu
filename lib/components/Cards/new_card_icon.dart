import 'package:flutter/material.dart';
import 'package:taxawu/theme/app_colors.dart';

class NewsCardIcon extends StatelessWidget {
  final String title;
  final String update;
  final bool hasAction;
  final IconData? icon;
  final Color color;
  final Color iconColor;

  const NewsCardIcon(
      {super.key,
      required this.title,
      required this.color,
      required this.iconColor,
      required this.update,
      this.icon,
      this.hasAction = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.blanc,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: AppColors.noir.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ]),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 5,
          children: [
            Container(
              margin: EdgeInsets.only(right: 5),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color,
              ),
              child: Icon(icon, color: iconColor),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: AppColors.noir, fontWeight: FontWeight.bold),
                ),
                Text(
                  update,
                  style: TextStyle(fontSize: 9, color: AppColors.gris),
                )
              ],
            )),
            IconButton(
              onPressed: () {},
              icon: Icon(hasAction ? Icons.chevron_right : null),
            )
          ]),
    );
  }
}
