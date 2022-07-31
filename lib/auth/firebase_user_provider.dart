import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FinWallerFirebaseUser {
  FinWallerFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

FinWallerFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<FinWallerFirebaseUser> finWallerFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<FinWallerFirebaseUser>(
        (user) => currentUser = FinWallerFirebaseUser(user));
