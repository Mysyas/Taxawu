import 'package:flutter/material.dart';
import 'package:taxawu/theme/app_colors.dart';

class UpperCard extends StatelessWidget {
  final IconData? logo;
  final String title;
  final String? text;
  const UpperCard({super.key, this.logo, required this.title, this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: const BoxDecoration(
        color: AppColors.vertFonce,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(45),
          bottomRight: Radius.circular(45),
        ),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Center(
            child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(.8),
              borderRadius: BorderRadius.circular(50),
              image: const DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                  fit: BoxFit.cover)),
        )),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
              color: AppColors.blanc,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          text ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w100,
          ),
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
