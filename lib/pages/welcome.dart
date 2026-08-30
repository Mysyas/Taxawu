import 'package:flutter/material.dart';
import 'package:taxawu/pages/authentification.dart';
import 'package:taxawu/theme/app_colors.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  @override
  _WidgetState createState() => _WidgetState();
}

class _WidgetState extends State<WelcomeScreen> {
  final PageController _controller = PageController();
  int currentSlide = 0;
  final List<Map<String, String>> slides = [
    {
      "title": "Bienvenue,\ndans l'application",
      "content": "Explorez et apprenez notre écosystème à travers des images",
      "image":
          "https://plus.unsplash.com/premium_photo-1675432656807-216d786dd468?q=80&w=990&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "title": "Découvrez",
      "content": "Naviguez facilement entre les contenus interactifs.",
      "image": ""
    }
  ];

  void goToSlide(int index) {
    _controller.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.vertFonce,
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.blanc,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: slides.length,
                  onPageChanged: (index) {
                    setState(() => currentSlide = index);
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        slides[index]['image']!.isEmpty
                            ? Container(
                                height: 300,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.gris.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  slides[index]["image"]!,
                                  height: 300,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 300,
                                      width: double.infinity,
                                      color: AppColors.gris.withOpacity(0.2),
                                      child: Icon(Icons.broken_image,
                                          size: 40, color: AppColors.gris),
                                    );
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      height: 300,
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      child: const CircularProgressIndicator(
                                        color: AppColors.vertClair,
                                      ),
                                    );
                                  },
                                ),
                              ),
                        const SizedBox(height: 30),
                        Text(
                          slides[index]["title"]!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          slides[index]["content"]!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(slides.length, (index) {
                      bool isActive = currentSlide == index;
                      return GestureDetector(
                        onTap: () => goToSlide(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.only(right: 6),
                          height: 6,
                          width: isActive ? 60 : 30,
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.vertFonce
                                : AppColors.gris.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    }),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AuthPage()));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text("Commencez"),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
