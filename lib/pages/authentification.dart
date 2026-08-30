import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:taxawu/pages/connexion.dart';
import 'package:taxawu/pages/register.dart';
import 'package:taxawu/theme/app_colors.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: AppColors.grisClair,
            body: Column(children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.noir.withValues(alpha: 0.15),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: const Offset(0, 5))
                          ]),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      child: const SizedBox(
                          height: 35,
                          child: TabBar(
                            tabs: [
                              Tab(text: "Connexion", height: 30),
                              Tab(text: "Inscription", height: 30)
                            ],
                          )))),
              const Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: TabBarView(
                  children: [LoginPage(), SignUpPage()],
                ),
              ))
            ])));
  }
}
