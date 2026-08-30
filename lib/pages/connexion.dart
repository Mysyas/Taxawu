import 'package:flutter/material.dart';
import 'package:taxawu/pages/homepage.dart';
import 'package:taxawu/theme/app_colors.dart';
import 'package:taxawu/components/FormFields/Custom_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  bool rememberMe = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    if (_formKey.currentState!.validate()) {
      debugPrint("Email : ${emailController.text}");
      debugPrint("Password : ${passwordController.text}");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Connexion réussie"),
          duration: Duration(seconds: 2),
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Homepage(),
          ),
        );
      });
      // TODO : Appeler votre API
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          //color: AppColors.blanc.withOpacity(0.8),
          padding: const EdgeInsets.all(25),
          child: Column(children: [
            const Card(
                color: AppColors.vertFonce,
                child: SizedBox(
                    height: 100,
                    child: Center(
                        child: ListTile(
                      title: Text(
                        "Bon retour sur Taxawu",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.blanc,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Connectez-vous pour retrouver votre collection et vos progrès.",
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
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value ?? false;
                          });
                        },
                      ),
                      const Text("Se souvenir de moi"),
                    ],
                  ),

                  const SizedBox(height: 25),

                  /// Bouton Connexion
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                        onPressed: login,
                        child: Text("Se connecter",
                            style: TextStyle(fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.orange,
                        )),
                  ),
                  const Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: AppColors.gris,
                        thickness: 1,
                      )),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Text(
                          "OU CONTINUER AVEC",
                          style: TextStyle(
                            color: AppColors.gris,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        color: AppColors.gris,
                        thickness: 1,
                      ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 12,
                    children: [
                      Expanded(
                          child: SizedBox(
                              height: 40,
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                label: const Text("Google"),
                                icon: Image.asset(
                                  "assets/images/google.png",
                                  width: 12,
                                ),
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: AppColors.noir,
                                    backgroundColor: AppColors.blanc,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    side: BorderSide(
                                        color: AppColors.lineColor, width: 1)),
                              ))),
                      Expanded(
                          child: SizedBox(
                              height: 40,
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                label: const Text("Apple"),
                                icon: Image.asset(
                                  "assets/images/apple-logo.png",
                                  width: 12,
                                ),
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: AppColors.noir,
                                    backgroundColor: AppColors.blanc,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    side: BorderSide(
                                        color: AppColors.lineColor, width: 1)),
                              )))
                    ],
                  )
                ],
              ),
            ),
          ])),
    );
  }
}
