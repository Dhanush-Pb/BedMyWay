// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:bedmyway/repositories/components/Bottm_page.dart';
import 'package:bedmyway/repositories/custom/page_transition.dart';
import 'package:bedmyway/view/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

Future<void> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      print("User canceled sign-in");
      return;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential.user == null) {
      return;
    }

    if (userCredential.user != null) {
      Navigator.of(context)
          .pushReplacement(FadePageRoute(page: const NavigationMenu()));
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Logingpage()),
      );
    }
  } catch (error) {
    log("Error signing in with Google: $error");

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Logingpage()),
    );
  }
}

Future<void> signOut(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();

    await GoogleSignIn().signOut();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Logingpage()),
      (Route<dynamic> route) => false,
    );
  } catch (error) {
    // ignore: avoid_print
    print("Error signing out: $error");
  }
}
