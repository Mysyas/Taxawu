import 'package:flutter/material.dart';
import 'package:taxawu/theme/app_colors.dart';

class Avatar extends StatelessWidget {
  final String? logo;
  final String? subtituteText;

  const Avatar({super.key, this.logo, this.subtituteText});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: AppColors.vertFonce,
        backgroundImage:
            (logo != null && logo!.isNotEmpty) ? AssetImage(logo!) : null,
        child: ((logo == null || logo!.isEmpty) && subtituteText!.isNotEmpty)
            ? Text(
                subtituteText!,
                style: const TextStyle(
                  color: AppColors.blanc,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            : null);
  }
}
