import 'package:flutter/material.dart';
import 'package:taxawu/helpers/welcome_slides.dart';
import 'package:taxawu/models/slide_content.dart';
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
  final List<SlideComponent> slides = WelcomeSlides.slides;

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
                        Expanded(
                            child: slides[index].image.isEmpty
                                ? Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.7,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.gris.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      slides[index].image,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.6,
                                          width: double.infinity,
                                          color: AppColors.gris
                                              .withValues(alpha: 0.2),
                                          child: const Icon(Icons.broken_image,
                                              size: 40, color: AppColors.gris),
                                        );
                                      },
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.6,
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          child:
                                              const CircularProgressIndicator(
                                            color: AppColors.vertClair,
                                          ),
                                        );
                                      },
                                    ),
                                  )),
                        const SizedBox(height: 30),
                        Text(
                          slides[index].title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          slides[index].content,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: 20,
                        )
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
                                : AppColors.gris.withValues(alpha: 0.3),
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
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
