import 'package:flutter/material.dart';
import 'package:taxawu/components/Cards/avatar.dart';
import 'package:taxawu/components/Cards/new_card.dart';
import 'package:taxawu/components/Cards/new_card_icon.dart';
import 'package:taxawu/components/Cards/scanner_card.dart';
import 'package:taxawu/helpers/especes_helper.dart';
import 'package:taxawu/models/espece_model.dart';
import 'package:taxawu/theme/app_colors.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../components/Cards/espece_card.dart';

class mainPage extends StatefulWidget {
  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  List<String> categories = [];
  String categorieSelectionnee = '';
  List<Espece> species = [];
  Map<String, dynamic> icons = EspeceHelper.family_icons;
  Map<String, dynamic> icons_colors = EspeceHelper.family_colors;
  final SpeechToText _speech = SpeechToText();
  final TextEditingController _controller = TextEditingController();
  bool _isListening = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      categories = EspeceHelper.families;
      species = EspeceHelper.allSpecies();
      categorieSelectionnee = '';
    });
  }

  @override
  void dispose() {
    super.dispose();
    _speech.stop();
    species = [];
  }

  Future<void> _parler() async {
    if (_isListening) {
      await _speech.stop();
      if (mounted) {
        setState(() => _isListening = false);
      }
      return;
    }

    final disponible = await _speech.initialize(
      onStatus: (status) {
        if (status == 'notListening' || status == 'done') {
          if (mounted) {
            setState(() => _isListening = false);
          }
        }
      },
      onError: (error) {
        if (mounted) {
          setState(() => _isListening = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Erreur vocale : ${error.errorMsg}',
              ),
            ),
          );
        }
      },
    );

    if (!disponible) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Reconnaissance vocale indisponible.',
          ),
        ),
      );
      return;
    }

    if (!mounted) return;
    setState(() => _isListening = true);

    await _speech.listen(
      localeId: 'fr_FR',
      onResult: (result) {
        setState(() {
          _controller.text = result.recognizedWords;
          _controller.selection = TextSelection.collapsed(
            offset: _controller.text.length,
          );
          species = EspeceHelper.allSpecies()
              .where((e) => e.nom
                  .toLowerCase()
                  .contains(result.recognizedWords.toLowerCase()))
              .toList();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: 70,
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              spacing: 10,
              children: [
                Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/logo.png"),
                              fit: BoxFit.fitHeight)),
                    )),
                Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      backgroundColor: AppColors.blanc,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Badge(
                              isLabelVisible: false,
                              child: Icon(Icons.notifications_none))),
                    )),
                const Expanded(flex: 1, child: Avatar(subtituteText: "AN"))
              ],
            ),
          ),
        ),
        Container(
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.blanc,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppColors.noir.withValues(alpha: 0.08),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: Colors.grey,
                size: 32,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: "Rechercher une espèce, un lieu...",
                    labelStyle: TextStyle(fontSize: 11),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    debugPrint('Valeur :${value}');
                    setState(() {
                      species = EspeceHelper.allSpecies()
                          .where((e) =>
                              e.nom.toLowerCase().contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                ),
              ),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: _parler,
                  icon: Icon(
                    _isListening ? Icons.square : Icons.mic_none,
                    color: _isListening ? Colors.red : Colors.green.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
        const ScannerCard(),
        Container(
            margin: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text("Catégories",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
        SizedBox(
          height: 55,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              String categorie = categories[index];

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: ChoiceChip(
                  showCheckmark: false,
                  selectedColor: categorie == "Animal"
                      ? Colors.brown.shade50
                      : (categorie == "Végétal"
                          ? Colors.green.shade50
                          : Colors.blue.shade50),
                  label: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 3,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: icons_colors[categorie]['bg'],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            icons[categorie],
                            color: icons_colors[categorie]['color'],
                          ),
                        ),
                        Text(categorie)
                      ]),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                    side: BorderSide.none,
                  ),
                  side: BorderSide.none,
                  elevation: 2,
                  pressElevation: 1,
                  selected: categorieSelectionnee == categorie,
                  onSelected: (value) {
                    setState(() {
                      if (value) {
                        categorieSelectionnee = categorie;
                        species = EspeceHelper.filteredSpecies(
                            categorieSelectionnee, "");
                        debugPrint("Categorie : ${species.map((e) => e.nom)}");
                      } else {
                        categorieSelectionnee = '';
                        species = EspeceHelper.allSpecies();
                      }
                    });
                  },
                ),
              );
            },
          ),
        ),
        Padding(
            padding: EdgeInsets.all(20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Espèces recommandées",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF202020),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigation vers toutes les espèces
                    },
                    child: Row(
                      children: const [
                        Text(
                          "Voir tout",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.chevron_right,
                          size: 30,
                          color: Color(0xFF2E7D32),
                        ),
                      ],
                    ),
                  ),
                ])),
        SizedBox(
            height: 255,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 28, right: 15, bottom: 20),
              itemCount: species.length,
              itemBuilder: (context, index) {
                return SpeciesCard(
                  espece: species[index],
                );
              },
            )),
        Container(
          height: 150,
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xFF0277BD), Color(0xFF024F82)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(children: [
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      child: Text(
                        "QUIZ DU JOUR",
                        style: TextStyle(color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFFE4F1FA).withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(20))),
                  Text(
                    "Testez vos connaissances",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: Text(
                    "5 questions sur la faune & flore du Sénégal. +50 XP à la clé.",
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ))
                ])),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.chevron_right,
                size: 25,
                color: AppColors.blanc,
              ),
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: AppColors.grisClair.withValues(alpha: 0.3)),
            )
          ]),
        ),
        Padding(
            child: NewsCardIcon(
              icon: Icons.map,
              title: "Découvrir près de moi",
              update: "12 espèces signalés dans un rayon 5 km",
              hasAction: true,
              color: Colors.blue.shade50,
              iconColor: Colors.blue,
            ),
            padding: EdgeInsets.all(15)),
        Container(
            margin: EdgeInsets.only(right: 20, top: 5, left: 20, bottom: 20),
            alignment: Alignment.centerLeft,
            child: Text("Actualités biodiversité",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
        Padding(
            child: NewsCard(
              image: "assets/images/news1.jpg",
              title:
                  "Le Sénégal renforce la protection de ses mangroves côtières",
              update: "Il y a 3h",
            ),
            padding: EdgeInsets.only(right: 20, left: 20, bottom: 5)),
        Padding(
            child: NewsCard(
              image: "assets/images/sea-turtles.jpg",
              title:
                  "Recensement des tortues marines : une saison record aux Îles de la Madeleine",
              update: "Hier",
            ),
            padding: EdgeInsets.all(15)),
        Padding(
            child: NewsCard(
              image: "assets/images/old_baobab.jpg",
              title: "Comment le baobab s'adapte au changement climatique ?",
              update: "Il y a 2 jours",
            ),
            padding: EdgeInsets.only(right: 20, left: 20, bottom: 20))
      ]),
    );
  }
}
