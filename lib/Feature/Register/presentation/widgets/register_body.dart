import 'package:fashon_app/Feature/Login/manger/login_cubit.dart';
import 'package:fashon_app/Feature/Login/manger/login_states.dart';
import 'package:fashon_app/Feature/Login/presentation/login_page.dart';
import 'package:fashon_app/core/utils/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class RegisterBody extends StatelessWidget {
  // const RegisterBody({super.key});
  var emailCont = TextEditingController();
  var passCont = TextEditingController();
  var nameCont = TextEditingController();
  var mobileCont = TextEditingController();
  var formkey = GlobalKey<FormState>();

  RegisterBody(
      {super.key,
      required this.emailCont,
      required this.mobileCont,
      required this.nameCont,
      required this.passCont});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      builder: (BuildContext context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                customTextFormedFiled(
                    val: "Eroor please Enter It",
                    controller: nameCont,
                    hintText: "name",
                    type: TextInputType.name,
                    preicon: Icons.person_2_outlined),
                const SizedBox(
                  height: 10,
                ),
                customTextFormedFiled(
                    val: "Eroor please Enter It",
                    controller: emailCont,
                    hintText: "email",
                    type: TextInputType.emailAddress,
                    preicon: Icons.email_outlined),
                const SizedBox(
                  height: 10,
                ),
                customTextFormedFiled(
                    val: "Eroor please Enter It",
                    controller: passCont,
                    hintText: "password",
                    type: TextInputType.text,
                    preicon: Icons.lock,
                    sufficon: LoginCubit.get(context).password,
                    sufFunction: () {
                      LoginCubit.get(context).changePasswordIcon();
                    },
                    obscureText: LoginCubit.get(context).ispassword),
                const SizedBox(
                  height: 10,
                ),
                customTextFormedFiled(
                    val: "Eroor please Enter It",
                    controller: mobileCont,
                    hintText: "phone",
                    type: TextInputType.number,
                    preicon: Icons.phone),
                const SizedBox(
                  height: 15,
                ),
                state is LoadingRegisterUser
                    ? const CircularProgressIndicator()
                    : defaultButton(
                        fun: () {
                          if (formkey.currentState!.validate()) {
                            LoginCubit.get(context)
                                .createAccount(
                              email: emailCont.text,
                              mobile: mobileCont.text,
                              password: passCont.text,
                              name: nameCont.text,
                            )
                                .then((value) {
                              print("done");
                              // Get.to(() => const HomeView());
                            });
                          }
                        },
                        text: "Register"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(" you are Member ?"),
                    TextButton(
                        onPressed: () {
                          // Get.to(() => const LoginPage());
                          NavegatorPush(context, const LoginPage());
                        },
                        child: const Text("Login Now!")),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
