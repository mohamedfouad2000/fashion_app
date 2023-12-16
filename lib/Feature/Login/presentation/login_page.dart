import 'package:fashon_app/Feature/Home/presentation/home.dart';
import 'package:fashon_app/Feature/Login/manger/login_cubit.dart';
import 'package:fashon_app/Feature/Login/manger/login_states.dart';
import 'package:fashon_app/Feature/Login/presentation/widgets/login_view_body.dart';
import 'package:fashon_app/core/constans/end_point.dart';
import 'package:fashon_app/core/local/cache_Helper.dart';
import 'package:fashon_app/core/utils/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailCont = TextEditingController();
    var passCont = TextEditingController();
    return BlocConsumer<LoginCubit, LoginStates>(
        builder: (BuildContext context, state) {
      return Scaffold(
        body: SingleChildScrollView(
            child: LoginViewBody(
          emailCont: emailCont,
          passCont: passCont,
        )),
        // resizeToAvoidBottomInset: false,
      );
    }, listener: (BuildContext context, Object? state) {
      if (state is SuccLoginUser) {
        // print("${state.ErrorMessage} ----------------------Aha");
        if (state.model!.status == true) {
          TOKEN = state.model!.data!.token;
          UID = state.uid;
          CacheHelper.saveData(key: "Token", value: state.model!.data!.token)
              .then((value) {
            CacheHelper.saveData(key: "UID", value: state.uid).then((value) {
              showToast(msg: state.model?.errorMessageEn, n: SelectToast.eroor);
              Nav(context, const Homepage());
            });
          });
        } else {
          print("object Siu ");
          showToast(msg: state.ErrorMessage, n: SelectToast.eroor);
        }
      } else if (state is eroorLoginUser) {
        showToast(msg: state.eroor, n: SelectToast.eroor);
      }
    });
  }
}
