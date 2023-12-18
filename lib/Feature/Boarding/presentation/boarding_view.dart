import 'package:fashon_app/Feature/Boarding/presentation/widgets/boarding_view_body.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_cubit.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoardingView extends StatelessWidget {
  const BoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return const Scaffold(
          body: BoardingViewBody(),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
