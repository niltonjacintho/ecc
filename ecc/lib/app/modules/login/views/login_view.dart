import 'package:ecc/app/modules/home/views/home_view.dart';
import 'package:ecc/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(const LoginView());

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  LoginPage({super.key});

  Future<UserCredential?> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    return userCredential;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            const Positioned.fill(
              child: Image(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 400),
              child: Center(
                child: Positioned(
                  bottom: 90,
                  child: IconButton(
                    icon: Image.asset('assets/images/google-logo.jpg'),
                    iconSize: 150,
                    onPressed: () {
                      _signInWithGoogle()
                          .then((UserCredential? userCredential) {
                        if (userCredential != null) {
                          print(userCredential.user);
                          Get.off(const HomeView());
                          // User signed in successfully, navigate to the next screen
                        } else {
                          // Failed to sign in
                        }
                      });
                    },
                    //   },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}