import 'package:flutter/material.dart';
import 'package:taxawu/theme/app_colors.dart';

class NewsCard extends StatelessWidget {
  final String? image;
  final String title;
  final String update;
  final bool hasAction;

  const NewsCard(
      {super.key,
      this.image,
      required this.title,
      required this.update,
      this.hasAction = false});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(25),
        child: Container(
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
              spacing: 10,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.blanc,
                      image: DecorationImage(
                          image: AssetImage(image!),
                          alignment: Alignment.center,
                          fit: BoxFit.fill)),
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
                if (hasAction)
                  IconButton(
                    onPressed: () {},
                    icon: Icon(hasAction ? Icons.chevron_right : null),
                  )
              ]),
        ),
        onTap: () {});
  }
}
