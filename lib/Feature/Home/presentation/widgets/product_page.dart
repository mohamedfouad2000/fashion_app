import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:fashon_app/Feature/Home/presentation/manger/home_cubit.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_states.dart';

import 'package:fashon_app/Feature/Home/presentation/widgets/product_item.dart';
import 'package:fashon_app/core/constans/end_point.dart';

import 'package:fashon_app/core/utils/components.dart';
import 'package:fashon_app/core/utils/size_config.dart';
import 'package:fashon_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).pro?.data != null &&
              HomeCubit.get(context).slid != null,
          builder: (BuildContext context) {
            return HomeCubit.get(context).pro?.data?.data?.isNotEmpty == true
                ? Column(
                    children: [
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        childAspectRatio: SizeConfig.screenWidth! *
                            1.2 /
                            (SizeConfig.screenHeight!),
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(
                            HomeCubit.get(context).pro!.data!.data!.length,
                            (index) => proItem(
                                  context: context,
                                  pro: HomeCubit.get(context)
                                      .pro!
                                      .data!
                                      .data![index],
                                )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeCubit.get(context).pro?.data?.currentPage !=
                                  HomeCubit.get(context).pro?.data?.from
                              ? IconButton(
                                  onPressed: () {
                                    HomeCubit.get(context).getProduct(
                                        page: (HomeCubit.get(context)
                                                .pro
                                                ?.data
                                                ?.currentPage)! -
                                            1,
                                        uId: UID);
                                  },
                                  icon: const Icon(
                                      Icons.arrow_back_ios_new_outlined))
                              : Opacity(
                                  opacity: 0.0,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          Icons.arrow_back_ios_new_outlined)),
                                ),
                          Container(
                            height: 25,
                            width: 25,
                            decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.all(
                                    Radius.elliptical(10, 10))),
                            // color: Colors.red,
                            child: Text(
                              "${HomeCubit.get(context).pro?.data?.currentPage}",
                              textAlign: TextAlign.center,
                              style: StylesData.TitleStyle.copyWith(
                                  color: Colors.white),
                            ),
                          ),
                          HomeCubit.get(context).pro?.data?.currentPage !=
                                  HomeCubit.get(context).pro?.data?.lastPage
                              ? IconButton(
                                  onPressed: () {
                                    HomeCubit.get(context).getProduct(
                                        page: (HomeCubit.get(context)
                                                .pro
                                                ?.data
                                                ?.currentPage)! +
                                            1,
                                        uId: UID);
                                  },
                                  icon: const Icon(
                                      Icons.arrow_forward_ios_outlined))
                              : Opacity(
                                  opacity: 0.0,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          Icons.arrow_forward_ios_outlined)),
                                ),
                        ],
                      ),
                    ],
                  )
                : SizedBox(child: Lottie.asset('assets/img/nodata.json'));
          },
          fallback: (BuildContext context) {
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is AddOrRemoveFavSucc) {
          showToast(msg: state.msq, n: SelectToast.eroor);
        }
      },
    );
  }
}
