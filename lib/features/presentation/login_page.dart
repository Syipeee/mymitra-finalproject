import 'package:flutter/material.dart';
import 'package:mitra_app/features/components/login_component.dart';
import 'package:mitra_app/features/components/theme.dart';
import 'package:mitra_app/features/presentation/home_mbkm_page.dart';
import 'package:mitra_app/features/presentation/providers/vmitra_providers.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Keluar Aplikasi'),
              content: const Text('Yakinn kamu mau keluar? 🥺️🥺️😔️'),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white),
                    child: const Text('Ngga Jadi')),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Keluar'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: const Color(0xfff3f3f3),
        body: Center(
          child: ListView(
            children: [
              const SizedBox(height: 60),
              Align(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(90),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(255, 219, 219, 219),
                                spreadRadius: 4,
                                blurRadius: 10)
                          ]),
                    ),
                    ClipRRect(
                        child: Image.asset(
                      width: 100,
                      height: 100,
                      'assets/images/kampus-merdeka.png',
                    )),
                  ],
                ),
              ),
              const Column(
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    greetings,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 23,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    instruction,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Color.fromARGB(255, 202, 202, 202)),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 35,
                  horizontal: 50,
                ),
                child: AutofillGroup(
                  onDisposeAction: AutofillContextAction.commit,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller:
                            context.read<VmitraProviders>().usernameController,
                        autofillHints: const [
                          AutofillHints.email,
                          AutofillHints.username
                        ],
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none),
                          ),
                          hintText: emailHintText,
                          hintStyle: const TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller:
                            context.read<VmitraProviders>().passwordController,
                        autofillHints: const [AutofillHints.password],
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              )),
                          hintText: passwordHintText,
                          hintStyle: const TextStyle(color: Colors.black),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                            icon: Icon(passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !passwordVisible,
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            handleLogin(context);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: bluePens,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  void handleLogin(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    try {
      await Provider.of<VmitraProviders>(
        context,
        listen: false,
      ).getVmitraData(
        username: context.read<VmitraProviders>().usernameController.text,
        password: context.read<VmitraProviders>().passwordController.text,
        onSuccess: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeMbkmPage(),
            ),
          );
        },
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
