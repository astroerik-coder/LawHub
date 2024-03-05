import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:lawhub/constants.dart';
import 'package:lawhub/models/user.dart';
import 'package:lawhub/services/helper.dart';

class FireStoreUtils {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Reference storage = FirebaseStorage.instance.ref();

  static Future<User?> getCurrentUser(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> userDocument =
        await firestore.collection(USERS).doc(uid).get();
    if (userDocument.data() != null && userDocument.exists) {
      return User.fromJson(userDocument.data()!);
    } else {
      return null;
    }
  }

  static Future<User> updateCurrentUser(User user) async {
    return await firestore
        .collection('USERS')
        .doc(user.userID)
        .set(user.toJson())
        .then((document) {
      return user;
    });
  }

  static Future<String> uploadUserImageToServer(
      File image, String userID) async {
    Reference upload = storage.child("images/$userID.png");
    UploadTask uploadTask = upload.putFile(image);
    var downloadUrl =
        await (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
    return downloadUrl.toString();
  }

  /// Iniciar sesión con correo electrónico y contraseña con Firebase.
  /// @param email Correo electrónico del usuario.
  /// @param password Contraseña del usuario.
  static Future<dynamic> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      auth.UserCredential result = await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await firestore.collection('USERS').doc(result.user?.uid ?? '').get();
      User? user;
      if (documentSnapshot.exists) {
        user = User.fromJson(documentSnapshot.data() ?? {});
      }
      return user;
    } on auth.FirebaseAuthException catch (exception, s) {
      debugPrint(exception.toString() + '$s');
      switch ((exception).code) {
        case 'invalid-email':
          return 'La dirección de correo electrónico es incorrecta.';
        case 'wrong-password':
          return 'Contraseña incorrecta.';
        case 'user-not-found':
          return 'No se encontró ningún usuario con la dirección de correo electrónico proporcionada.';
        case 'user-disabled':
          return 'Este usuario ha sido deshabilitado.';
        case 'too-many-requests':
          return 'Demasiados intentos de iniciar sesión con este usuario.';
      }
      return 'Error inesperado de Firebase. Por favor, inténtalo de nuevo.';
    } catch (e, s) {
      debugPrint(e.toString() + '$s');
      return 'Error al iniciar sesión. Por favor, inténtalo de nuevo.';
    }
  }

  /// Guardar un nuevo documento de usuario en la tabla de USUARIOS en Firestore de Firebase.
  /// Devuelve un mensaje de error en caso de fallo o nulo en caso de éxito.
  static Future<String?> createNewUser(User user) async => await firestore
      .collection('USERS')
      .doc(user.userID)
      .set(user.toJson())
      .then((value) => null, onError: (e) => e);

  static signUpWithEmailAndPassword(
      {required String emailAddress,
      required String password,
      File? image,
      firstName = 'Anónimo',
      lastName = 'Usuario'}) async {
    try {
      auth.UserCredential result = await auth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailAddress, password: password);
      String profilePicUrl = '';
      if (image != null) {
        updateProgress('Subiendo imagen, por favor espera...');
        profilePicUrl =
            await uploadUserImageToServer(image, result.user?.uid ?? '');
      }
      User user = User(
          email: emailAddress,
          firstName: firstName,
          userID: result.user?.uid ?? '',
          lastName: lastName,
          profilePictureURL: profilePicUrl);
      String? errorMessage = await createNewUser(user);
      if (errorMessage == null) {
        return user;
      } else {
        return 'No se pudo registrar en Firebase. Por favor, inténtalo de nuevo.';
      }
    } on auth.FirebaseAuthException catch (error) {
      debugPrint(error.toString() + '${error.stackTrace}');
      String message = 'No se pudo registrar';
      switch (error.code) {
        case 'email-already-in-use':
          message = 'Correo electrónico ya en uso. ¡Por favor, elige otro correo electrónico!';
          break;
        case 'invalid-email':
          message = 'Introduce un correo electrónico válido';
          break;
        case 'operation-not-allowed':
          message = 'Las cuentas de correo electrónico/contraseña no están habilitadas';
          break;
        case 'weak-password':
          message = 'La contraseña debe tener más de 5 caracteres';
          break;
        case 'too-many-requests':
          message = 'Demasiadas solicitudes. Por favor, inténtalo de nuevo más tarde.';
          break;
      }
      return message;
    } catch (e) {
      return 'No se pudo registrar';
    }
  }

  static logout() async {
    await auth.FirebaseAuth.instance.signOut();
  }

  static Future<User?> getAuthUser() async {
    auth.User? firebaseUser = auth.FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      User? user = await getCurrentUser(firebaseUser.uid);
      return user;
    } else {
      return null;
    }
  }

  static Future<dynamic> loginOrCreateUserWithPhoneNumberCredential({
    required auth.PhoneAuthCredential credential,
    required String phoneNumber,
    String? firstName = 'Anónimo',
    String? lastName = 'Usuario',
    File? image,
  }) async {
    auth.UserCredential userCredential =
        await auth.FirebaseAuth.instance.signInWithCredential(credential);
    User? user = await getCurrentUser(userCredential.user?.uid ?? '');
    if (user != null) {
      return user;
    } else {
      /// Crear un nuevo usuario a partir del inicio de sesión con el número de teléfono.
      String profileImageUrl = '';
      if (image != null) {
        profileImageUrl = await uploadUserImageToServer(
            image, userCredential.user?.uid ?? '');
      }
      User user = User(
          firstName:
              firstName!.trim().isNotEmpty ? firstName.trim() : 'Anónimo',
          lastName: lastName!.trim().isNotEmpty ? lastName.trim() : 'Usuario',
          email: '',
          profilePictureURL: profileImageUrl,
          userID: userCredential.user?.uid ?? '');
      String? errorMessage = await createNewUser(user);
      if (errorMessage == null) {
        return user;
      } else {
        return 'No se pudo crear un nuevo usuario con el número de teléfono.';
      }
    }
  }

  static resetPassword(String emailAddress) async =>
      await auth.FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailAddress);
}
