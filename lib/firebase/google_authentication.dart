// import 'package:figgy/utils/utils.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class GoogleAuthentication {
//   static Future<UserCredential?> signInWithGoogle() async {
//     try {
//       final GoogleSignIn googleSignIn = GoogleSignIn(
//         scopes: ['email'],
//         serverClientId: '523031370909-g7mhnaqrshgv1kjedmp0am0bm64of4kj.apps.googleusercontent.com',
//       );
//
//       await googleSignIn.signOut();
//       final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//       final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
//
//       final credential = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
//       final result = await FirebaseAuth.instance.signInWithCredential(credential);
//
//       Utils.showLog("Google Authentication Response => $result");
//
//       Utils.showLog("Google Authentication Name => ${result.user?.displayName}");
//       Utils.showLog("Google Authentication Email => ${result.user?.email}");
//       Utils.showLog("Google Authentication Image => ${result.user?.photoURL}");
//       Utils.showLog("Google Authentication isNewUser => ${result.additionalUserInfo?.isNewUser}");
//
//       return result;
//     } catch (error) {
//       Utils.showLog("Google Authentication Error => $error");
//     }
//     return null;
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthentication {
  // Fallback values
  static String? lastUsedEmail;
  static String? lastUsedName;
  static String? lastUsedPhoto;

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/userinfo.email',
          'https://www.googleapis.com/auth/userinfo.profile',
        ],
        serverClientId:
            '276451904837-an5jtej90vmge4derns10gr2lb1k8uka.apps.googleusercontent.com',
      );

      // Remove previous session
      await googleSignIn.signOut();

      // Choose Account
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      print(
          "===========================\n$googleUser r\n========================");
      if (googleUser == null) return null;

      // Save fallback values
      lastUsedEmail = googleUser.email;
      lastUsedName = googleUser.displayName;
      lastUsedPhoto = googleUser.photoUrl;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return result;
    } catch (e) {
      print("Google Login Error => $e");
      return null;
    }
  }
}
