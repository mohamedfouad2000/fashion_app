import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fashon_app/Feature/Home/data/brand_model/datum.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_cubit.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_states.dart';
import 'package:fashon_app/Feature/Home/presentation/screens/search_product.dart';
import 'package:fashon_app/core/constans/end_point.dart';
import 'package:fashon_app/core/utils/colors.dart';
import 'package:fashon_app/core/utils/components.dart';
import 'package:fashon_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class BrandPage extends StatelessWidget {
  BrandPage({super.key, required this.catId});
  int? catId;
  @override
  Widget build(BuildContext context) {
    HomeCubit.get(context).getBrands();
    return BlocConsumer<HomeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          // appBar: mainAppBar(context: context, x: "Brands"),
          appBar: AppBar(
            title: const Text("Brands"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: ConditionalBuilder(
              condition: state is! GetBrandsLoading,
              builder: (BuildContext context) {
                return GridView.count(
                  crossAxisCount: 3,
                  // shrinkWrap: true,
                  childAspectRatio: .6,
                  // physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(
                      HomeCubit.get(context).brands!.data!.length,
                      (index) => productCard(
                          pro: HomeCubit.get(context).brands!.data![index],
                          catId: catId,
                          context: context)),
                );
                // return GridView.builder(gridDelegate: gridDelegate, itemBuilder: itemBuilder)
              },
              fallback: (BuildContext context) {
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}

Widget productCard({
  required DatumMmm? pro,
  context,
  required int? catId,
}) {
  // int.tryParse(pro?.price.to);
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        NavegatorPush(context, SearchProduct(brandId: pro?.id, catId: catId));
      },
      child: Container(
        // height: SizeConfig.screenHeight! * .50,
        decoration: BoxDecoration(
          color: kMainColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: CachedNetworkImage(
                // height: SizeConfig.screenHeight! * .40,
                imageUrl: "$IMGURL${pro?.img}",
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${pro?.name}',
              style: StylesData.TitleStyle.copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    ),
  );
}
