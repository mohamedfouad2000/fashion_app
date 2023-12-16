import 'package:fashon_app/Feature/Login/manger/login_cubit.dart';
import 'package:fashon_app/Feature/Login/manger/login_states.dart';
import 'package:fashon_app/Feature/Login/presentation/login_page.dart';
// import 'package:fashon_app/Feature/Login/presentation/login_page.dart';
import 'package:fashon_app/Feature/Register/presentation/widgets/register_body.dart';
import 'package:fashon_app/core/utils/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    var emailCont = TextEditingController();
    var passCont = TextEditingController();
    var nameCont = TextEditingController();
    var mobileCont = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) {
        return LoginCubit();
      },
      child: BlocConsumer<LoginCubit, LoginStates>(
        builder: (BuildContext context, state) {
          return Scaffold(
            body: SingleChildScrollView(
                child: RegisterBody(
                    emailCont: emailCont,
                    mobileCont: mobileCont,
                    nameCont: nameCont,
                    passCont: passCont)),
          );
        },
        listener: (BuildContext context, Object? state) {
          if (state is SuccRegisterUser) {
            if (state.msg == '') {
              showToast(msg: 'Create Done Login Now', n: SelectToast.eroor);
            } else {
              showToast(msg: '${state.msg}', n: SelectToast.eroor);
            }

            if (state.state == true) {
              Nav(context, const LoginPage());
            }
          } else if (state is eroorRegisterUser) {
            showToast(msg: state.eroor, n: SelectToast.eroor);
          }
        },
      ),
    );
  }
}
