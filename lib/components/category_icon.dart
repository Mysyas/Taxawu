import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxawu/theme/app_colors.dart';

class CategoryIcon extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color bgColor;
  final Color? iconColor;
  final bool isActive;

  const CategoryIcon({
    super.key,
    required this.label,
    required this.bgColor,
    this.icon,
    this.iconColor,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(22),
          ),
          child: isActive && icon != null
              ? Icon(icon, color: iconColor, size: 32)
              : null,
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: AppColors.noir.withOpacity(0.87),
          ),
        ),
      ],
    );
  }
}
