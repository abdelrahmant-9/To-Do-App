import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthRemoteDataSource(this.firestore);

  Future<UserModel?> getUserProfile(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data()!);
    }
    return null;
  }

  Future<UserModel?> signIn(String email, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final firebaseUser = userCredential.user;
    if (firebaseUser != null) {
      final doc = await firestore.collection('users').doc(firebaseUser.uid).get();
      if (doc.exists && doc.data()!.containsKey('name') && doc.data()!['name'] != null) {
        return UserModel.fromJson(doc.data()!);
      } else {
        final userModel = UserModel(
          id: firebaseUser.uid,
          email: firebaseUser.email!,
          name: firebaseUser.displayName,
        );
        await firestore.collection('users').doc(firebaseUser.uid).set(userModel.toJson(), SetOptions(merge: true));
        return userModel;
      }
    }
    return null;
  }

  Future<UserModel?> signUp(String email, String password, String name) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user != null) {
      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.reload();
      final updatedUser = _auth.currentUser;

      final userModel = UserModel(id: updatedUser!.uid, email: email, name: name);
      await firestore.collection('users').doc(updatedUser.uid).set(userModel.toJson());
      return userModel;
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
