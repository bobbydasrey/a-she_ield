import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class AnimatedLoginPage extends StatefulWidget {
  final bool isFirstTime;
  const AnimatedLoginPage({super.key, this.isFirstTime = true});

  @override
  State<AnimatedLoginPage> createState() => _AnimatedLoginPageState();
}

class _AnimatedLoginPageState extends State<AnimatedLoginPage> {
  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //late Rive Controllers;
  StateMachineController? _controller;
  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<double>? lookDownRight;

  // Text Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Focus Nodes
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(_onEmailFocusChange);
    _passwordFocusNode.addListener(_onPasswordFocusChange);
  }

  void _onEmailFocusChange() {
    isChecking?.change(_emailFocusNode.hasFocus);
  }

  void _onPasswordFocusChange() {
    isHandsUp?.change(_passwordFocusNode.hasFocus);
  }

  void _onRiveInit(Artboard artboard) {
    _controller = StateMachineController.fromArtboard(artboard, 'Login Machine');
    if (_controller != null) {
      artboard.addController(_controller!);
      isChecking = _controller?.findInput('isChecking');
      isHandsUp = _controller?.findInput('isHandsUp');
      lookDownRight = _controller?.findInput('lookDownRight');
    }
  }

  void _submit() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final name = nameController.text.trim();
    //final phone = phoneController.text.trim();

    try {
      if (widget.isFirstTime) {
        // Registration
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // Optional: Update display name
        await user.user?.updateDisplayName(name);

        // TODO: Save phone number to Firebase DB if needed

      } else {
        // Login
        await _auth.signInWithEmailAndPassword(email: email, password: password);
      }
      if (!mounted) return;

      // Navigate to HomePage or Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      if (!mounted) return;
      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC6EDCE),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),

            // Rive Animation
            SizedBox(
              height: 250,
              child: RiveAnimation.network(
                'https://public.rive.app/community/runtime-files/2191-4327-animated-login-character.riv',
                onInit: _onRiveInit,
                fit: BoxFit.contain,
              ),
            ),

            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  if (widget.isFirstTime) ...[
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: "Full Name"),
                      onChanged: (val) => lookDownRight?.change(val.length.toDouble()),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(labelText: "Phone Number"),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 10),
                  ],

                  TextField(
                    controller: emailController,
                    focusNode: _emailFocusNode,
                    decoration: const InputDecoration(labelText: "Email"),
                    onChanged: (val) => lookDownRight?.change(val.length.toDouble() * 2),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    focusNode: _passwordFocusNode,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: "Password"),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: _submit,
                      child: Text(
                        widget.isFirstTime ? "Register" : "Login",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //@override
  //void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    //super.debugFillProperties(properties);
    //properties.add(DiagnosticsProperty<Rive>('Controllers', Controllers));
    //properties.add(DiagnosticsProperty<Rive>('Controllers', Controllers));
  }
//}

// Placeholder Home Page after login
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: const Center(
        child: Text(
          "Welcome to SHE-IELD!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
