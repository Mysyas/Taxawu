import 'package:flutter/material.dart';
import 'package:taxawu/theme/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: AppColors.blanc,
        boxShadow: [
          BoxShadow(
            color: AppColors.lineColor,
            blurRadius: 20,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(Icons.home_outlined, "Accueil", 0),
          _item(Icons.map_outlined, "Explorer", 1),
          Transform.translate(
            offset: const Offset(0, -25),
            child: GestureDetector(
              onTap: () => onTap(2),
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.orangeAccent,
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    )
                  ],
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.blanc,
                  size: 32,
                ),
              ),
            ),
          ),
          _item(Icons.my_location_outlined, "Carte", 3),
          _item(Icons.person_outline, "Profil", 4),
        ],
      ),
    );
  }

  Widget _item(IconData icon, String text, int index) {
    final selected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: selected ? const Color(0xffEAF5EB) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: selected ? Colors.green : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: TextStyle(
              color: selected ? Colors.green : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
