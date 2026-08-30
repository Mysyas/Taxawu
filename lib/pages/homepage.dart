import 'package:flutter/material.dart';
import 'package:taxawu/components/NavigationBar/custom_bottomNavbar.dart';
import 'package:taxawu/pages/explorepage.dart';
import 'package:taxawu/pages/mainPage.dart';
import 'package:taxawu/theme/app_colors.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  int currentIndex = 0;
  final List<Widget> pages = [mainPage(), const explorePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNav(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          }),
      backgroundColor: AppColors.grisClair,
      body: SafeArea(child: pages[currentIndex]),
      /*body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // ── Bouton Menu Burger ─────────────────────────────────────────
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(Icons.menu_rounded, color: AppColors.noir, size: 36),
                onPressed: () {},
              ),
              const SizedBox(height: 32),

              // ── Titre Principal ────────────────────────────────────────────
              Text(
                'Découvrez une espèce',
                style: GoogleFonts.fredoka(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: AppColors.vertFonce,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 24),

              // ── Barre de Recherche ─────────────────────────────────────────
              Container(
                decoration: BoxDecoration(
                  color: AppColors.gris.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(28),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                child: Row(
                  children: [
                    Icon(Icons.search_rounded, color: AppColors.gris, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        style: GoogleFonts.montserrat(color: AppColors.noir),
                        decoration: InputDecoration(
                          hintText: 'Recherchez une espèce',
                          hintStyle: GoogleFonts.montserrat(
                              color: AppColors.gris, fontSize: 16),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ScanPage()),
                      ),
                      child: Icon(
                        Icons.crop_free_rounded,
                        color: AppColors.vertFonce,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),

              // ── Section Catégories ─────────────────────────────────────────
              Text(
                "Catégories d'espèces",
                style: GoogleFonts.fredoka(
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                    color: AppColors.vertFonce),
              ),
              const SizedBox(height: 20),
              const _CategoriesRow(),
              const SizedBox(height: 36),

              // ── Section Recommandations ────────────────────────────────────
              Text(
                'Nos recommandations du jour',
                style: GoogleFonts.fredoka(
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                    color: AppColors.vertFonce),
              ),
              const SizedBox(height: 20),
              const _RecommendationsRow(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),*/
    );
  }
}
