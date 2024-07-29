import 'package:flutter/material.dart';
import 'package:mitra_app/features/components/theme.dart';
import 'package:mitra_app/features/presentation/login_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset('assets/images/kampus-merdeka.png')),
              const SizedBox(
                height: 12,
              ),
              const CircularProgressIndicator(
                backgroundColor: yellowPens,
                valueColor: AlwaysStoppedAnimation(bluePens),
              ),
              const SizedBox(
                height: 6,
              ),
              const Text('Menghubungkan ke server...'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false,
      );
    });
  }
}
