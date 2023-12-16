import 'package:fashon_app/Feature/Register/data/user_model/user_model.dart';

abstract class LoginStates {}

class InitLoginState extends LoginStates {}

class ChangePassword extends LoginStates {}

class LoadingRegisterUser extends LoginStates {}

class SuccRegisterUser extends LoginStates {
  String? msg = '';
  bool? state = false;
  SuccRegisterUser({required this.msg, required this.state});
}

class eroorRegisterUser extends LoginStates {
  String? eroor;
  eroorRegisterUser({required this.eroor});
}

class LoadingLoginUser extends LoginStates {}

class SuccLoginUser extends LoginStates {
  String? ErrorMessage;
  UserModel? model;
  int? uid;
  SuccLoginUser(
      {required this.model, required this.ErrorMessage, required this.uid});
}

class eroorLoginUser extends LoginStates {
  String? eroor;
  eroorLoginUser({required this.eroor});
}
