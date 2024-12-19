import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class EmployeeSettingController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var user = Rxn<User>();

  @override
  void onInit() {
    user.value = _auth.currentUser;
    super.onInit();
  }

  Future<void> verifyEmail() async {
    await _auth.currentUser!.sendEmailVerification();
    await _auth.currentUser!.reload();
    user.value = _auth.currentUser;
  }

  Future<void> reloadUser() async {
    await _auth.currentUser!.reload();
    user.value = _auth.currentUser;
  }

  Future<void> deleteUser() async {
    await _auth.currentUser!.delete();
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
