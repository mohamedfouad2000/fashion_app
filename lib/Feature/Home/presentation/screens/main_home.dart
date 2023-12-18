import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_cubit.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_states.dart';
import 'package:fashon_app/Feature/Home/presentation/widgets/carouslslider.dart';
import 'package:fashon_app/Feature/Home/presentation/widgets/categoey_list.dart';
import 'package:fashon_app/Feature/Home/presentation/widgets/product_page.dart';
import 'package:fashon_app/core/utils/components.dart';
import 'package:fashon_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class MainHome extends StatelessWidget {
  MainHome({super.key, required this.searchController});
  TextEditingController? searchController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return ConditionalBuilder(
          condition: state is! GetCategoryLoading &&
              HomeCubit.get(context).cat != null,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  textFileldSearch(
                      context: context, searchController: searchController!),
                  const SizedBox(
                    height: 10,
                  ),
                  HomeCubit.get(context).slid != null
                      ? carSlider(data: HomeCubit.get(context).slid!.data)
                      : const Center(child: CircularProgressIndicator()),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Category",
                    style: StylesData.TitleStyle,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CategoryList(),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    children: [
                      Text(
                        "Best ",
                        style: StylesData.TitleStyle,
                      ),
                      Text(
                        "Saller",
                        style: StylesData.TitleStyleColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  HomeCubit.get(context).pro != null &&
                          HomeCubit.get(context).slid != null
                      ? const ProductPage()
                      : const Center(child: CircularProgressIndicator()),

                  // const Products(),
                ],
              ),
            );
          },
          fallback: (BuildContext context) {
            return Center(
              child: state is GetCategoryError ||
                      state is GetProductError ||
                      state is GetSliderError
                  ? Lottie.asset("assets/img/404.json")
                  : const CircularProgressIndicator(),
            );
          },
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
