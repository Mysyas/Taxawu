import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taxawu/models/espece_model.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:taxawu/theme/app_colors.dart';

class EspeceHelper {
  static List<String> families = [
    "Mammifère",
    "Oiseau",
    "Poisson",
    "Reptile",
    "Amphibien",
    "Insecte",
    "Arachnide",
    "Mollusque",
    "Crustacé",
    "Angiosperme",
    "Champignon",
  ];
  static Map<String, dynamic> family_icons = {
    "Mammifère": FontAwesomeIcons.horse,
    "Oiseau": FontAwesomeIcons.dove,
    "Poisson": FontAwesomeIcons.fish,
    "Reptile": CommunityMaterialIcons.snake,
    "Amphibien": FontAwesomeIcons.frog,
    "Insecte": FontAwesomeIcons.bug,
    "Arachnide": FontAwesomeIcons.spider,
    "Mollusque": CommunityMaterialIcons.snail,
    "Crustacé": FontAwesomeIcons.shrimp,
    "Angiosperme": FontAwesomeIcons.seedling,
    "Champignon": CommunityMaterialIcons.mushroom,
  };
  static List<Espece> allSpecies() {
    return [
      Espece(
          lieu: "Réserve de Bandia",
          nom: "Baobab",
          categorie: "Végétal",
          nomScientifique: "Adansonia digitata",
          description:
              "Le baobab pousse généralement de façon assez clairsemée. Il a un tronc ventru et un bois tendre gorgé d'eau (appelé pour cette raison arbre bouteille). Avec son allure caractéristique, il est généralement très massif et peut atteindre 25 m de haut et plus de 20 m de circonférence; son diamètre atteint 5 à 7 m[2]. Il présente au sommet du tronc une couronne de branches irrégulières et dépourvues de feuilles pendant la majeure partie de la saison sèche, ce qui peut représenter une longue période dans les zones où la saison des pluies est courte[2]. C'est une des explications à son appellation « l'arbre à l'envers », car avec ses rameaux nus, il paraît avoir été retourné avec ses racines au sommet.",
          shortDescription:
              "Le Baobab africain (Adansonia digitata) est une espèce de plantes à fleurs du genre Adansonia et de la famille des Bombacacées, selon la classification classique, ou des Malvacées, selon la classification phylogénétique.",
          image:
              "https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Baobab_and_elephant%2C_Tanzania.jpg/1920px-Baobab_and_elephant%2C_Tanzania.jpg?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=thumbnail&_=20180417071510",
          famille: "Angiosperme"),
      Espece(
          lieu: "Parc Niokolo Koba",
          nom: "Lion",
          categorie: "Animal",
          famille: "Mammifère",
          description:
              """Le Lion (Panthera leo) est une espèce de mammifères carnivores de la famille des Félidés. La femelle du lion est la lionne, son petit est le lionceau. Le mâle adulte, aisément reconnaissable à son importante crinière, accuse une masse moyenne qui peut être variable selon les zones géographiques où il se trouve, allant de 145 à 180 kg pour les lions d'Asie à plus de 225 kg pour les lions d'Afrique. Certains spécimens très rares peuvent dépasser exceptionnellement 300 kg. Un mâle adulte se nourrit de 7 kg de viande chaque jour contre 5 kg chez la femelle. Le lion est un animal grégaire, c'est-à-dire qu'il vit en larges groupes familiaux, contrairement aux autres félins. Son espérance de vie, à l'état sauvage, est comprise entre 7 et 12 ans pour le mâle et 14 à 20 ans pour la femelle, mais il dépasse fréquemment les 30 ans en captivité.
        Le lion mâle ne chasse qu'occasionnellement, il est chargé de combattre les intrusions sur le territoire et les menaces contre la troupe. Le lion rugit. Il n'existe plus à l'état sauvage que 16 500 à 30 000 individus dans la savane africaine, répartis en deux sous-espèces, et environ 300 dans le parc national de Gir Forest (nord-ouest de l'Inde). Il est surnommé « le roi des animaux » car sa crinière lui donne un aspect semblable au Soleil, qui apparaît comme « le roi des astres ». Entre 1993 et 2017, sa population a baissé de 43 %[1].""",
          nomScientifique: "Panthera leo",
          shortDescription:
              "Le Lion ( Panthera leo ) est une espèce de mammifères carnivores de la famille des Félidés. La femelle du lion est la lionne, son petit est le lionceau.",
          image:
              "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg/960px-011_The_lion_king_Tryggve_in_the_Serengeti_National_Park_Photo_by_Giles_Laurent.jpg?utm_source=fr.wikipedia.org&utm_campaign=parser&utm_content=thumbnail"),
      Espece(
          lieu: "Delta du Saloum",
          nom: "Requin",
          categorie: "Animal",
          famille: "Poisson",
          description:
              """Les requins, squales ou sélachimorphes forment un super-ordre des poissons cartilagineux, possédant cinq à sept fentes branchiales sur les côtés de la tête et les nageoires pectorales qui ne sont pas fusionnées à la tête. Ils sont présents dans tous les océans du globe et dans certains grands fleuves. Les requins modernes sont classés au sein du super-ordre Selachimorpha ou Selachii et constituent le groupe-frère des raies modernes au sein de la micro-classe Neoselachii. Toutefois, le terme « requin », au sens large, désigne aussi communément des espèces disparues de la sous-classe des Elasmobranchii, comme Cladoselache et Xenacanthus, qui appartiennent à d’autres infra-classes qu’Euselachii. Les premiers requins sont apparus au Dévonien, il y a environ 420 Ma. À partir du Crétacé, il y a 100 Ma, beaucoup de lignées de requins ont adopté leur forme moderne. Depuis, il existe plus de 500 espèces de requins regroupées en 35 familles, sans compter les espèces de raies, aujourd'hui considérées comme des requins à part entière[1]. Certaines espèces ne sont connues que par leurs fossiles. Leur taille varie de seulement vingt centimètres de longueur pour Etmopterus perryi, à plus de vingt mètres pour le requin-baleine. Malgré sa taille, ce dernier se nourrit principalement de plancton en filtrant l'eau de mer. Mais la plupart des requins sont des prédateurs, voire des superprédateurs. Les requins sont présents dans toutes les mers, jusqu'à une profondeur d'environ 2 500 mètres. Ils ne vivent généralement pas dans l'eau douce, mais il y a quelques exceptions, telles que le requin-bouledogue et les requins de rivière qui peuvent vivre aussi bien dans l'eau de mer que dans l'eau douce. Les requins ont un revêtement de denticules dermiques qui protègent leur peau contre les parasites, en plus d'améliorer leur hydrodynamisme. Ils ont également plusieurs rangées de dents qui se renouvellent régulièrement. Malgré une mauvaise réputation véhiculée par les médias, seulement cinq espèces sont considérées comme dangereuses pour l'être humain. Selon l'Union internationale pour la conservation de la nature (UICN), environ un tiers des espèces de requins est menacé d'extinction (surpêche, prise accessoire, élimination gratuite, etc.).
      Ils sont utilisés par l'être humain pour de nombreux usages, comme l'alimentation, la maroquinerie, le tourisme, les cosmétiques et sont parfois maintenus en captivité. En tant que superprédateurs, les requins sont indispensables à leur écosystème. La protection mondiale des requins reste faible, mais certains États décident de transformer leurs eaux territoriales en sanctuaire de requins.""",
          nomScientifique: "Selachimorpha, Selachii",
          image:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLB_J5Bc4Y0ykHZq7U5g1R_MmdzodfhBoo642xPVWP7w&s=10",
          shortDescription:
              "Les requins, squales ou sélachimorphes forment un super-ordre des poissons cartilagineux, possédant cinq à sept fentes branchiales sur les côtés de la tête et les nageoires pectorales qui ne sont pas fusionnées à la tête. Ils sont présents dans tous les océans du globe et dans certains grands fleuves.")
    ];
  }

  static List<Espece> filteredSpecies(String? famille, String nom) {
    return allSpecies()
        .where((element) =>
            (famille == null || element.famille == famille) &&
            element.nom.contains(nom))
        .toList();
  }

  static Map<String, dynamic> family_colors = {
    "Mammifère": {"bg": Colors.brown.shade100, "color": Colors.brown.shade700},
    "Oiseau": {
      "bg": Colors.limeAccent.shade100,
      "color": Colors.limeAccent.shade700
    },
    "Poisson": {"bg": Colors.blue.shade100, "color": Colors.blue.shade700},
    "Reptile": {
      "bg": Colors.blueGrey.shade100,
      "color": Colors.blueGrey.shade700
    },
    "Amphibien": {
      "bg": Colors.lightBlueAccent.shade100,
      "color": Colors.lightBlueAccent.shade700
    },
    "Insecte": {"bg": Colors.grey.shade100, "color": Colors.grey.shade700},
    "Arachnide": {"bg": Colors.amber.shade100, "color": Colors.amber.shade700},
    "Mollusque": {
      "bg": Colors.deepOrange.shade100,
      "color": Colors.deepOrange.shade700
    },
    "Crustacé": {
      "bg": Colors.orangeAccent.shade100,
      "color": Colors.orangeAccent.shade700
    },
    "Angiosperme": {
      "bg": Colors.green.shade100,
      "color": Colors.green.shade700
    },
    "Champignon": {
      "bg": Colors.redAccent.shade100,
      "color": Colors.redAccent.shade700
    },
  };
}
