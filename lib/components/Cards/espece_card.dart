import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taxawu/helpers/especes_helper.dart';
import 'package:taxawu/models/espece_model.dart';
import 'package:taxawu/theme/app_colors.dart';

class SpeciesCard extends StatelessWidget {
  final Espece espece;

  const SpeciesCard({
    super.key,
    required this.espece,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 238,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          SizedBox(
            height: 153,
            child: Stack(
              children: [
                // Image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 260,
                    child: Image.network(
                      espece.image ??
                          "https://cdn-icons-png.flaticon.com/128/14040/14040433.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Catégorie
                Positioned(
                  left: 20,
                  bottom: 18,
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: _categoryColor(espece),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 5,
                          children: [
                            Icon(
                              EspeceHelper.family_icons[espece.famille],
                              /*espece.categorie == "Végétal"
                                  ? FontAwesomeIcons.tree
                                  : (espece.categorie == "Animal"
                                      ? Icons.pets
                                      : FontAwesomeIcons.fish),*/
                              color: EspeceHelper.family_colors[espece.famille]
                                  ['color'],
                              size: 12,
                            ),
                            Text(
                              espece.famille!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ])),
                ),

                // Bouton favoris
                Positioned(
                  top: 18,
                  right: 20,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // Ajouter aux favoris
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: AppColors.grisClair,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite_border,
                          size: 25,
                          color: Color(0xFFD94848),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          // Informations
          Padding(
            padding: const EdgeInsets.fromLTRB(26, 10, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  espece.nom,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF242424),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  espece.nomScientifique,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF8A9188),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.gps_fixed,
                      size: 10,
                      color: Color(0xFF969D94),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        espece.lieu,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF969D94),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _categoryColor(Espece categorie) {
    debugPrint(espece.famille);
    return EspeceHelper.family_colors[espece.famille]['bg']
        .withValues(alpha: 0.7);
    /*switch (categorie) {
      case "Animal":
        return const Color(0xFF916D52).withValues(alpha: 0.7);

      case "Poisson":
        return const Color(0xFF087FC2).withValues(alpha: 0.7);

      case "Végétal":
        return const Color(0xFF6A8E4E).withValues(alpha: 0.7);

      default:
        return const Color(0xFF777777).withValues(alpha: 0.7);
    }*/
  }
}
