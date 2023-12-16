import 'package:fashon_app/Feature/Home/presentation/manger/home_cubit.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class EroorPage extends StatelessWidget {
  const EroorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          body: Center(
            child: SizedBox(
              child: Lottie.asset('assets/img/404.json'),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
