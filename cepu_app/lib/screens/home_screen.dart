import 'package:cepu_app/screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
      (route) => false,
    );
  }

  String generateAvatarUrl(String? fullName) {
    final formattedName = fullName?.trim().replaceAll('', '+');
    return 'https://ui-avatars.com/api/?name=$formattedName&background=random';
  }

  String? _idToken = "";
  String? _uid = "";
  String? _email = "";

  @override
  void initState() {
    super.initState();
    getFirebaseAuthUser();
  }

  Future<void> getFirebaseAuthUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _uid = user.uid;
      _email = user.email;
      await user
          .getIdToken(true)
          .then(
            (v) => {
              setState(() {
                _idToken = v;
              }),
            },
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(
              generateAvatarUrl(
                FirebaseAuth.instance.currentUser?.displayName!,
              ),
              width: 120,
              height: 120,
            ),
            SizedBox(height: 8.0),
            Text(
              FirebaseAuth.instance.currentUser!.displayName!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            Text("Your have been signed in with ID Token: $_idToken"),
            Text("current User: $_uid"),
            Text("Current Email: $_email"),
          ],
        ),
      ),
    );
  }
}
