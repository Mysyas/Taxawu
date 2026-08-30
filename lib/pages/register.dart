import 'package:flutter/material.dart';
import 'package:taxawu/theme/app_colors.dart';
import 'package:taxawu/components/FormFields/Custom_form_field.dart';
import 'package:taxawu/theme/app_theme.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Color strengthStep1 = AppColors.gris.withValues(alpha: 0.8);
  Color strengthStep2 = AppColors.gris.withValues(alpha: 0.8);
  Color strengthStep3 = AppColors.gris.withValues(alpha: 0.8);
  String passwordText = "";
  int score = 0;

  bool obscurePassword = true;
  bool obscurePassword2 = true;
  bool acceptCondition = false;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(() {
      final text = passwordController.text;
      setState(() {
        if (text.length >= 8) {
          score = 1;
          if (RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=\\/\[\]~`]').hasMatch(text)) {
            score++;
          }
          if (RegExp(r'\d').hasMatch(text)) {
            score++;
          }
        } else {
          score = 0;
        }
        if (score == 0) {
          strengthStep1 = AppColors.gris.withValues(alpha: 0.8);
          strengthStep2 = AppColors.gris.withValues(alpha: 0.8);
          strengthStep3 = AppColors.gris.withValues(alpha: 0.8);
          passwordText = "Minimum 8 caractères";
        } else if (score == 1) {
          strengthStep1 = Colors.redAccent;
          passwordText = "Mot de passe faible";
          strengthStep2 = AppColors.gris.withValues(alpha: 0.8);
          strengthStep3 = AppColors.gris.withValues(alpha: 0.8);
        } else if (score == 2) {
          strengthStep1 = Colors.redAccent;
          strengthStep2 = Colors.orangeAccent;
          strengthStep3 = AppColors.gris.withValues(alpha: 0.8);
          passwordText = "Mot de passe moyen";
        } else if (score == 3) {
          strengthStep1 = Colors.redAccent;
          strengthStep2 = Colors.orangeAccent;
          strengthStep3 = Colors.green;
          passwordText = "Mot de passe fort";
        }
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    userController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void register() {
    if (_formKey.currentState!.validate()) {
      debugPrint("Email : ${emailController.text}");
      debugPrint("Password : ${passwordController.text}");
      debugPrint("Nom d'utilisateur : ${userController.text}");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Création réussie"),
        ),
      );
      DefaultTabController.of(context).animateTo(0);
      // TODO : Appeler votre API
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(25),
            child: Column(children: [
              const Card(
                  color: AppColors.orange,
                  child: SizedBox(
                      height: 100,
                      child: Center(
                          child: ListTile(
                        title: Text(
                          "Rejoignez Taxawu",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.blanc,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Créez votre compte pour identifier, explorer et apprendre sur la biodiversité.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w100,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        dense: true,
                      )))),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomFormField(
                        title: "Nom d'utilisateur",
                        controller: userController,
                        icon: const Icon(Icons.account_circle),
                        type: TextInputType.text,
                        hintText: "Taxawuz",
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Veuillez saisir le nom d'utilisation";
                          }
                          return null;
                        }),
                    const SizedBox(height: 20),
                    CustomFormField(
                        title: "Email",
                        controller: emailController,
                        icon: const Icon(Icons.email_outlined),
                        type: TextInputType.emailAddress,
                        hintText: "vous@exemple.com",
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Veuillez saisir votre adresse e-mail";
                          }

                          final regex = RegExp(
                            r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                          );

                          if (!regex.hasMatch(value.trim())) {
                            return "Adresse e-mail invalide";
                          }

                          return null;
                        }),
                    const SizedBox(height: 20),
                    CustomFormField(
                        title: "Mot de passe",
                        hintText: "Minimum 8 caractères",
                        controller: passwordController,
                        icon: const Icon(Icons.lock_outline),
                        type: TextInputType.emailAddress,
                        suffixedIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Veuillez saisir votre mot de passe";
                          }

                          if (value.length < 8) {
                            return "Minimum 8 caractères";
                          }

                          return null;
                        },
                        obscurePassword: obscurePassword),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 5,
                      children: [
                        Expanded(
                            child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                              color: strengthStep1,
                              borderRadius: BorderRadius.circular(3)),
                        )),
                        Expanded(
                            child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                              color: strengthStep2,
                              borderRadius: BorderRadius.circular(3)),
                        )),
                        Expanded(
                            child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                              color: strengthStep3,
                              borderRadius: BorderRadius.circular(3)),
                        ))
                      ],
                    ),
                    Text(passwordText),
                    const SizedBox(height: 10),
                    CustomFormField(
                        title: "Confirmer mot de passe",
                        hintText: ".......",
                        controller: confirmPasswordController,
                        icon: const Icon(Icons.lock_outline),
                        type: TextInputType.visiblePassword,
                        suffixedIcon: IconButton(
                          icon: Icon(
                            obscurePassword2
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword2 = !obscurePassword2;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value != passwordController.text) {
                            return "Les mots de passe ne correspondent pas";
                          }

                          return null;
                        },
                        obscurePassword: obscurePassword2),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          value: acceptCondition,
                          onChanged: (value) {
                            setState(() {
                              acceptCondition = value ?? false;
                            });
                          },
                        ),
                        Expanded(
                          child: Text.rich(
                            const TextSpan(
                              children: [
                                TextSpan(text: "J'accepte les "),
                                TextSpan(
                                  text: "Conditions d'utilisation",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(text: " et la "),
                                TextSpan(
                                  text: "Politique de confidentialité",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(text: " de Taxawu."),
                              ],
                            ),
                            softWrap: true,
                          ),
                        )
                        /*const Text(
                            "accepte les Conditions d'utilisation et la Politique de confidentialité de Taxawu."),*/
                      ],
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                          onPressed: register,
                          child: Text("Créer mon compte",
                              style: TextStyle(fontSize: 16)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.orange,
                          )),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
