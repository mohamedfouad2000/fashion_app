// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_cubit.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_states.dart';
import 'package:fashon_app/Feature/Home/presentation/widgets/product_item.dart';
import 'package:fashon_app/core/utils/components.dart';
import 'package:fashon_app/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SearchProduct extends StatelessWidget {
  SearchProduct({super.key, required this.brandId, required this.catId});
  int? brandId;
  int? catId;
  @override
  Widget build(BuildContext context) {
    HomeCubit.get(context)
        .getProductByBrandAndCat(brandId: brandId!, catId: catId!);
    print("${brandId!} ${catId!} ");
    return BlocConsumer<HomeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: mainAppBar(context: context),
          body: ConditionalBuilder(
            condition: HomeCubit.get(context).searchProduct?.status == true,
            builder: (BuildContext context) {
              return HomeCubit.get(context)
                          .searchProduct
                          ?.data
                          ?.data
                          ?.isNotEmpty ==
                      true
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
                              HomeCubit.get(context)
                                  .searchProduct!
                                  .data!
                                  .data!
                                  .length,
                              (index) => proItem(
                                    context: context,
                                    pro: HomeCubit.get(context)
                                        .searchProduct!
                                        .data!
                                        .data![index],
                                  )),
                        ),
                      ],
                    )
                  : SizedBox(child: Lottie.asset('assets/img/nodata.json'));
            },
            fallback: (BuildContext context) {
              return const Center(child: CircularProgressIndicator());
            },
          ),
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
