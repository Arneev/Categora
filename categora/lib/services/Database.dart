import 'package:categora/helpers/helper.dart';
import 'package:categora/helpers/log.dart';
import 'package:categora/helpers/toast.dart';
import 'package:categora/services/Firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Database implements Firebase {
  //Making the class a singleton
  Database._privateConstructor();
  static final Database instance = Database._privateConstructor();

  //Variables
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static UserCredential? _userCredential;

  //Intialization
  static Future<FirebaseApp> init() async {
    final firebaseApp = await Firebase.initializeApp();

    return firebaseApp;
  }

  //Getters
  static User? get user {
    return _auth.currentUser;
  }

  static FirebaseFirestore get firestore {
    return _firestore;
  }

  //Register user with Email & Password
  static Future<bool> register(
      {required String email, required String password}) async {
    log.i("About to Register");

    try {
      _userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      authExceptionHandler(e);
    } catch (e) {
      unknownError();
    }

    return false;
  }

  //Login user with email and password
  static Future<bool> login(
      {required String email, required String password}) async {
    log.i("About to Login");

    try {
      _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      authExceptionHandler(e);
    } catch (e) {
      unknownError();
    }

    return false;
  }

  //Forgot Password
  static Future<bool> forgotPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      authExceptionHandler(e);
    } catch (e) {
      unknownError();
    }

    return false;
  }

  static void resetPassword() {
    _auth.sendPasswordResetEmail(email: user!.email!);
  }

  static void logOut() {
    _auth.signOut();
  }

  static void deleteAccount() {
    FirestoreService.deleteUserData();
    user!.delete();
  }
}

//Helper Functions
void authExceptionHandler(FirebaseAuthException e) {
  String errorMsg = "";
  switch (e.code) {
    case "email-already-in-use":
      errorMsg = "This email is already registered.";
      break;
    case "invalid-email":
      errorMsg = "Invaild Email Address";
      break;
    case "operation-not-allowed":
      errorMsg = "Please contact us.";
      break;
    case "weak-password":
      errorMsg = "Password is too weak";
      break;
    case "user-disabled":
      errorMsg =
          "This email has been disabled. Please contact support for more information";
      break;
    case "user-not-found":
      errorMsg = "This email address is unregistered";
      break;
    case "wrong-password":
      errorMsg = "Invalid Password";
      break;
    case "network-request-failed":
      errorMsg = "Check your internet connection";
      break;

    default:
      errorMsg = e.toString();
  }

  //Return Error & False
  log.e(errorMsg);
  toast(errorMsg);
}

void networkException(e) {
  String errorMsg = "";

  // switch (e) {
  //   case :

  //     break;
  //   default:
  // }
}
