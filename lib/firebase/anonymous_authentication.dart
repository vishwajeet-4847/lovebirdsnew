import 'package:LoveBirds/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnonymousAuthentication {
  static Future<void> signInWithAnonymous() async {
    try {
      await FirebaseAuth.instance.signOut();
      final userCredential = await FirebaseAuth.instance.signInAnonymously();

      print("===================hello guys================$userCredential");
      Utils.showLog("New Anonymous Login Response => $userCredential");
    } catch (e) {
      print("========================\n $e \n====================");
      Utils.showLog("Anonymous Authentication Error => $e");
    }
  }
}
