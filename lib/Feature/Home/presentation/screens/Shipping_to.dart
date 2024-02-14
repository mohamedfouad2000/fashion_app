import 'package:fashon_app/Feature/Home/presentation/manger/home_cubit.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShippingTo extends StatelessWidget {
  const ShippingTo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          body: Stepper(currentStep: 2, elevation: 0.0, steps: const [
            Step(
                title: Text('Account'),
                content: Center(
                  child: Text('Account'),
                )),
            Step(
                title: Text('Address'),
                content: Center(
                  child: Text('Address'),
                )),
            Step(
                title: Text('Confirm'),
                content: Center(
                  child: Text('Confirm'),
                ))
          ]),
     
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
