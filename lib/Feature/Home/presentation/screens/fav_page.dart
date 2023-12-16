import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fashon_app/Feature/Home/data/fav_model/product.dart';
import 'package:fashon_app/Feature/Home/data/products_model/datum.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_cubit.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_states.dart';
import 'package:fashon_app/Feature/Home/presentation/screens/details.dart';
import 'package:fashon_app/core/constans/end_point.dart';
import 'package:fashon_app/core/utils/colors.dart';
import 'package:fashon_app/core/utils/components.dart';
import 'package:fashon_app/core/utils/size_config.dart';
import 'package:fashon_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class FavPage extends StatelessWidget {
  const FavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).fav != null,
          builder: (BuildContext context) {
            return HomeCubit.get(context).fav!.data! != [] &&
                    HomeCubit.get(context).fav?.result != false
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return favItem(
                              context: context,
                              model: HomeCubit.get(context)
                                  .fav!
                                  .data![index]
                                  .product);
                        },
                        itemCount: HomeCubit.get(context).fav!.data!.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 1,
                            // color: Colors.grey[400],
                            width: double.infinity,
                          );
                        },
                      ),
                    ),
                  )
                : Center(
                    child:
                        SizedBox(child: Lottie.asset('assets/img/empty.json')));
          },
          fallback: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
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

Widget favItem({required Product? model, required context}) {
  return favList?[model?.id] == true
      ? InkWell(
          onTap: () {
            print(favList);
            searchProduct(model?.id, context).then((value) {
              if (value.id == null) {
                print("siu Isuauiasuiduioasd");
                Datum d = Datum(
                    id: model?.id,
                    nameEn: model?.nameEn,
                    price: model?.price,
                    detailsEn: model?.detailsEn,
                    img: model?.img);

                // d.productAttributes[0].amount =model.
                NavegatorPush(context, DetailsPage(pro: d));
              } else {
                NavegatorPush(context, DetailsPage(pro: value));
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              height: SizeConfig.screenHeight! * .18,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(children: [
                  CachedNetworkImage(
                    height: SizeConfig.screenHeight! * .18,
                    // height: SizeConfig.screenHeight! * .25,
                    width: SizeConfig.screenWidth! * .40,
                    fit: BoxFit.cover,
                    imageUrl: "$IMGURL${model?.img}",
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error_outline),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${model?.nameEn}",
                          style: StylesData.pageIteamDetails.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              "\$",
                              style: StylesData.pageIteamDetails.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: kMainColor),
                            ),
                            Text(
                              "${model?.price}",
                              style: StylesData.pageIteamDetails.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w800),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                HomeCubit.get(context)
                                    .addOrRemoveFav(id: model?.id)
                                    .then((value) {
                                  print(
                                      "_______________________________________--");
                                  print(favList);
                                });
                              },
                              icon: favList?[model?.id] == true
                                  ? const Icon(Icons.favorite)
                                  : const Icon(Icons.favorite_border),
                              color: Colors.red,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        )
      : Container();
}

Future<Datum> searchProduct(uid, context) async {
  Datum? searchPro;
  for (var element in HomeCubit.get(context).pro!.data!.data!) {
    if (element.id == uid) {
      searchPro = element;
      break;
    }
  }
  return searchPro ?? Datum();
}
