import 'package:fashon_app/Feature/Home/data/profile_model/profile_model.dart';
import 'package:fashon_app/Feature/Home/presentation/home.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_cubit.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_states.dart';
import 'package:fashon_app/core/constans/end_point.dart';
import 'package:fashon_app/core/utils/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class EditProfile extends StatelessWidget {
  EditProfile(
      {super.key,
      required this.model,
      required this.emailCont,
      required this.mobileCont,
      required this.nameCont});
  ProfileModel model;
  TextEditingController? nameCont;
  TextEditingController? emailCont;
  TextEditingController? mobileCont;

  void set() {
    nameCont?.text = model.data!.name!;
    emailCont?.text = model.data!.email!;
    mobileCont?.text = model.data!.mobile!;
  }

  @override
  Widget build(BuildContext context) {
    set();
    return BlocConsumer<HomeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          appBar: mainAppBar(context: context, x: 'Edit Profile', cart: false),

          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                            radius: 50.0,
                            backgroundImage: NetworkImage(PERSONIMG)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 1.0,
                            color: Colors.grey[300],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: TextFormField(
                            controller: nameCont,
                            style: const TextStyle(fontSize: 20),
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              border: InputBorder.none,
                              // prefix: Icon(
                              //   Icons.person,
                              // ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 1.0,
                            color: Colors.grey[300],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: TextFormField(
                            style: const TextStyle(fontSize: 20),
                            controller: mobileCont,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'Phone',
                              border: InputBorder.none,
                              // prefix: Icon(
                              //   Icons.phone_android,
                              // ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 1.0,
                            color: Colors.grey[300],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: TextFormField(
                            controller: emailCont,
                            style: const TextStyle(fontSize: 20),
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'EmailController',
                              border: InputBorder.none,
                              // prefix: Icon(
                              //   Icons.email_outlined,
                              // ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      height: 60,
                      width: double.infinity / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: const LinearGradient(colors: [
                          Colors.blue,
                          Colors.lightBlue,
                          Colors.blue
                        ]),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          print(nameCont?.text);
                          print(int.tryParse('${mobileCont?.text}'));
                          print(emailCont?.text);

                          HomeCubit.get(context).editProfile(
                              user: nameCont!.text,
                              phone: mobileCont!.text,
                              email: emailCont!.text);
                        },
                        child: const Text(
                          "Confirm Edit",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is EditProfileDataSucc) {
          NavegatorPush(context, const Homepage());
          showToast(msg: state.msq, n: SelectToast.eroor);
        }
        if (state is EditProfileDataError) {
          showToast(msg: state.msq, n: SelectToast.eroor);
        }
      },
    );
  }
}
