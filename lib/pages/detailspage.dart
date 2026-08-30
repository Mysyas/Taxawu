import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxawu/theme/app_colors.dart';

class DetailsPage extends StatefulWidget {
  final String speciesName;

  const DetailsPage({super.key, required this.speciesName});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.blanc,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // ── 1. En-tête Supérieur Fixe ────────────────
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: AppColors.gris.withOpacity(0.08),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.chevron_left_rounded,
                              color: AppColors.noir, size: 30),
                        ),
                      ),
                      Text(
                        widget.speciesName,
                        style: GoogleFonts.fredoka(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppColors.vertFonce,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Container(
                        width: 46,
                        height: 46,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.favorite_border_rounded,
                            color: AppColors.noir.withOpacity(0.87), size: 26),
                      ),
                    ],
                  ),
                ),

                // ── Contenu Principal Défilant ──────────────
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 2. Zone d'Image
                        Stack(
                          children: [
                            Container(
                              height: size.height * 0.38,
                              width: double.infinity,
                              color: AppColors.gris.withOpacity(0.2),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 24,
                              child: Row(
                                children: List.generate(3, (index) {
                                  return Container(
                                    margin: const EdgeInsets.only(right: 6),
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _currentImageIndex == index
                                          ? AppColors.vertOlive
                                          : AppColors.gris.withOpacity(0.4),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),

                        // 3. Section Infos & Descriptifs
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description',
                                style: GoogleFonts.fredoka(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.vertFonce),
                              ),
                              const SizedBox(height: 10),
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      color: AppColors.gris,
                                      height: 1.4),
                                  children: [
                                    const TextSpan(
                                      text:
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec placerat, risus pulvinar aliquet faucibus, nisi quam luctus lectus, in gravida ex orci ac sem. ',
                                    ),
                                    TextSpan(
                                      text: 'Voir plus ...',
                                      style: GoogleFonts.montserrat(
                                          color: AppColors.vertOlive,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),

                              // 4. Grille de caractéristiques
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _InfoColumn(title: 'Nom', value: 'Outdoor'),
                                  _InfoColumn(
                                      title: 'Habitat', value: 'Medium'),
                                  _InfoColumn(title: 'Famille', value: 'Easy'),
                                ],
                              ),
                              const SizedBox(height: 28),

                              // 5. Section Espèces Similaires
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Espèces similaires',
                                    style: GoogleFonts.fredoka(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.vertFonce),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero),
                                    child: Text(
                                      'Voir plus',
                                      style: GoogleFonts.montserrat(
                                          color: AppColors.gris,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),

                              SizedBox(
                                height: 175,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  clipBehavior: Clip.none,
                                  children: const [
                                    _SimilarCard(name: 'Chin Cactus'),
                                    SizedBox(width: 16),
                                    _SimilarCard(name: 'Easter Cactus'),
                                    SizedBox(width: 16),
                                    _SimilarCard(name: 'Saguaro Cactus'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 80),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // ── 6. Bouton d'action fixe ──────────────
            Positioned(
              bottom: 16,
              left: 24,
              right: 24,
              child: SizedBox(
                height: 56,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.vertFonce,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    elevation: 0,
                  ),
                  child: Text(
                    'Ajoutez aux favoris',
                    style: GoogleFonts.montserrat(
                        color: AppColors.blanc,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoColumn extends StatelessWidget {
  final String title;
  final String value;

  const _InfoColumn({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: GoogleFonts.montserrat(
                fontSize: 13,
                color: AppColors.gris,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(value,
            style: GoogleFonts.montserrat(
                fontSize: 18,
                color: AppColors.noir,
                fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _SimilarCard extends StatelessWidget {
  final String name;

  const _SimilarCard({required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 135,
          height: 125,
          decoration: BoxDecoration(
            color: AppColors.gris.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.noir.withOpacity(0.87)),
        ),
      ],
    );
  }
}
