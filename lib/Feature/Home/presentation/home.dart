import 'package:fashon_app/Feature/Home/presentation/manger/home_cubit.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_states.dart';
import 'package:fashon_app/core/constans/end_point.dart';
import 'package:fashon_app/core/utils/components.dart';
import 'package:fashon_app/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        // var box = await Hive.openBox('testBox');

        return HomeCubit()
          ..getProfile()
          ..getCategory()
          ..getSlider()
          ..getProduct(uId: UID);
      },
      child: BlocConsumer<HomeCubit, HomeStates>(
        builder: (BuildContext context, state) {
          return Scaffold(
              appBar: mainAppBar(
                  cart: true,
                  context: context,
                  x: HomeCubit.get(context)
                      .headerName[HomeCubit.get(context).currentIndex!]),
              drawer: Drawer(
                elevation: 0.0,
                width: SizeConfig.screenWidth! * .6,
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                child: SingleChildScrollView(
                    child: Column(
                  children: [header(context), myDrawerList(context)],
                )),
              ),
              bottomNavigationBar: CurvedNavigationBar(
                backgroundColor: Colors.transparent,
                color: Colors.blue,
                buttonBackgroundColor: Colors.blue,

                // type: BottomNavigationBarType.fixed,
                height: 60,
                index: HomeCubit.get(context).currentIndex!,

                items: <Widget>[
                  Icon(
                    Icons.home,
                    color: HomeCubit.get(context).currentIndex == 0
                        ? Colors.white
                        : Colors.white.withOpacity(.8),
                  ),
                  Icon(Icons.favorite,
                      color: HomeCubit.get(context).currentIndex == 1
                          ? Colors.white
                          : Colors.white.withOpacity(.8)),
                  Icon(Icons.shopping_cart,
                      color: HomeCubit.get(context).currentIndex == 2
                          ? Colors.white
                          : Colors.white.withOpacity(.8)),
                  Icon(Icons.person,
                      color: HomeCubit.get(context).currentIndex == 3
                          ? Colors.white
                          : Colors.white.withOpacity(.8)),
                ],
                onTap: (value) {
                  HomeCubit.get(context).changeIndex(value: value);
                },
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: HomeCubit.get(context)
                    .screens[HomeCubit.get(context).currentIndex!],
              ));
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
