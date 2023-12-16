// import 'package:dio/dio.dart';
import 'package:fashon_app/Feature/Login/manger/login_states.dart';
import 'package:fashon_app/Feature/Register/data/user_model/user_model.dart';
import 'package:fashon_app/core/constans/end_point.dart';
import 'package:fashon_app/core/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitLoginState());
  static LoginCubit get(context) => BlocProvider.of(context);
  IconData password = Icons.remove_red_eye_sharp;
  bool ispassword = true;
  void changePasswordIcon() {
    ispassword = !ispassword;
    password =
        ispassword ? Icons.remove_red_eye_sharp : Icons.remove_red_eye_outlined;
    emit(ChangePassword());
  }

  // UserModel? userModel;
  Future<void> createAccount({
    required String name,
    required String mobile,
    required String email,
    required String password,
  }) async {
    emit(LoadingRegisterUser());
    DioHelper.postData(url: REGISTERURL, data: {
      'name': name,
      'mobile': mobile,
      'email': email,
      'password': password,
      'c_password': password,
    }).then((value) {
      // print(value.data);

      // USERMODEL = UserModel.fromJson(value.data);
      // print(USERMODEL?.status);
      emit(SuccRegisterUser(
          msg: value.data['error_message'], state: value.data['status']));

      // print(value.data);
      // print(userModel?.status);

      // TOKEN=
      // print(value.data['token']);
    }).catchError((onError) {
      // showToast(msg: onError, n: SelectToast.eroor);

      emit(eroorRegisterUser(eroor: onError.toString()));
      // print(onError);
    });
  }

  Future<void> login(
      {required String userName, required String password}) async {
    emit(LoadingLoginUser());
    // print("before ");
    DioHelper.postData(
      url: LOGINURL,
      data: {
        'phone_email': userName,
        'password': password,
      },
    ).then((value) {
      // print("-----------------------------------------------------------");
      // print(value.data['data']['id']);
      // print(value.data);
      // print("in Login");
      USERMODEL = UserModel.fromJson(value.data);
      // print(value.data);
      emit(SuccLoginUser(
          model: USERMODEL,
          ErrorMessage: value.data['message'],
          uid: value.data['data']['id']));
    }).catchError((onError) {
      // print(" omksadpkasodko ${onError.toString()}");
      emit(eroorLoginUser(eroor: onError.toString()));
    });
  }

//   Future<void> createUser({
//     required String email,
//     required String password,
//     required String phone,
//     required String name,
//   }) async {
//     emit(LoadingRegisterUser());
//     print("$email $password $phone $name");

//     FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: email, password: password)
//         // ignore: body_might_complete_normally_catch_error
//         .then((value) {
//       print(value.user!.uid);
//       createNewUserInFireStor(
//           email: email,
//           name: name,
//           password: password,
//           phone: phone,
//           Uid: value.user!.uid);
//       emit(SuccRegisterUser(Uid: value.user!.uid));
//     }).onError((error, stackTrace) {
//       print("objext eroor $error ");
//       emit(eroorRegisterUser(eroor: error.toString()));
//     });
//   }

//   void createNewUserInFireStor(
//       {required String email,
//       required String name,
//       required String password,
//       required String phone,
//       required String Uid}) {
//     print("object");
//     UserModel? model = UserModel(
//       email: email,
//       name: name,
//       password: password,
//       phone: phone,
//       Uid: Uid,
//       isAdmin: false,
//     );
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(Uid)
//         .set(model.tOMap())
//         .then((value) {
//       // emit(SuccRegisterUser(Uid: uid));
//       print("Don In cloud");
//     }).onError((error, stackTrace) {
//       print(error);
//       emit(eroorRegisterUser(eroor: error.toString()));
//     });
//   }

//   void loginWithEandP({
//     required String email,
//     required String password,
//   }) {
//     bool? isAdmin = false;
//     emit(LoadingLoginUser());
//     {}
//     FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: email, password: password)
//         .then((value) {
//       if (email == "admin@yahoo.com" && password == "1234554321") {
//         isAdmin = true;
//       }
//       emit(SuccLoginUser(
//         Uid: value.user!.uid,
//         isAdmin: isAdmin!,
//       ));
//     }).catchError((onError) {
//       emit(eroorLoginUser(eroor: onError.toString()));
//     });
//   }

//   bool? fav = false;
//   void cahngeFavIcon(bool x) {}

// }
}
