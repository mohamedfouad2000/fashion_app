import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_cubit.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_states.dart';
import 'package:fashon_app/Feature/Home/presentation/screens/edit_profile.dart';
import 'package:fashon_app/core/constans/end_point.dart';
import 'package:fashon_app/core/utils/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController nameCont = TextEditingController();
    TextEditingController emailCont = TextEditingController();
    TextEditingController mobileCont = TextEditingController();
    if (ProfileData == null) {
      HomeCubit.get(context).getProfile();
    }
    return BlocConsumer<HomeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return ConditionalBuilder(
          condition: ProfileData!.status != false,
          builder: (BuildContext context) {
            return Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      // color: Colors.blue,
                      ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 140,
                    child: Container(
                      alignment: const Alignment(0.0, 2.5),
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          PERSONIMG,
                        ),
                        radius: 70.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "${ProfileData?.data?.name}",
                  style: const TextStyle(
                      fontSize: 25.0,
                      color: Colors.blueGrey,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Email:",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.blue,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "${ProfileData?.data?.email}",
                      style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black45,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      " Mobile Number:",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.blue,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      " ${ProfileData?.data?.mobile} ",
                      style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black45,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                InkWell(
                  onTap: () {
                    NavegatorPush(
                        context,
                        EditProfile(
                            model: ProfileData!,
                            emailCont: emailCont,
                            mobileCont: mobileCont,
                            nameCont: nameCont));
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.lightBlue,
                            Colors.blue,
                            Colors.blueAccent,
                            Colors.lightBlue
                          ]),
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 150.0,
                        maxHeight: 40.0,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Edit Profile",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          fallback: (BuildContext context) {
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
