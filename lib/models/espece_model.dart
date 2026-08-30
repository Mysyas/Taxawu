class Espece {
  final String nom;
  final String? image;
  final String categorie;
  final String description;
  final String nomScientifique;
  final String shortDescription;
  final String lieu;
  final String? famille;

  Espece(
      {required this.nom,
      this.image,
      required this.categorie,
      required this.description,
      required this.nomScientifique,
      required this.shortDescription,
      required this.lieu,
      this.famille});
}
