import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyGoogleAuthentication {
  static String? id;
  static Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;

        // ignore: avoid_print
        print(user!.phoneNumber);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    return user;
  }

  static registerUserNumber(String mobile, BuildContext context) async {
    // ignore: no_leading_underscores_for_local_identifiers
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
      phoneNumber: mobile,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {
        // ignore: avoid_print
        print(error);
      },
      codeSent: (verificationId, forceResendingToken) {
        // ignore: avoid_print
        print(verificationId);
        id = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  // static verifyNumber(String pin, String id, BuildContext context) {
  //   // ignore: no_leading_underscores_for_local_identifiers
  //   FirebaseAuth _auth = FirebaseAuth.instance;
  //   var credential =
  //       PhoneAuthProvider.credential(verificationId: id, smsCode: pin);
  //   _auth.signInWithCredential(credential).then((result) {
  //     // ignore: avoid_print
  //     print("verify ");
  //   }).catchError((e) {
  //     // ignore: avoid_print
  //     print(e);
  //   });
  // }
}
