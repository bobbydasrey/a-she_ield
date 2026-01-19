import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'register_page.dart';
import 'login_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'She_ield',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const SheShieldSplash(), // Yaha splash screen call hoga,
    );
  }
}

class SheShieldSplash extends StatefulWidget {
  const SheShieldSplash({super.key});





  @override
  State<SheShieldSplash> createState() => _SheShieldSplashState();
}

class _SheShieldSplashState extends State<SheShieldSplash> {
  bool isOpened = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            //const SizedBox(height: 20),
            GestureDetector(
              onTap: () { setState(() => isOpened = true);

              // Sirf tab login page khulega jab shell open ho chuka hai
              Future.delayed(const Duration(seconds: 3), (){
                //WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const RegisterPage(),
                  ),
                );
              });
              },


              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 1000),
                child: isOpened
                    ? Image.asset('assets/open_shell_with_woman.jpeg', key: const ValueKey(1), height: 350)
                    : Image.asset('assets/closed_shell.jpeg', key: const ValueKey(2), height: 350),
              ),
            ),
            if (isOpened) ...[
              const SizedBox(height: 12),
              const Text(
                "She_ield",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const Text(
                "Your Safety, Our Priority",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
