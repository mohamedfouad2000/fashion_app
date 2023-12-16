// ignore_for_file: must_be_immutable
import 'package:fancy_cart/fancy_cart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fashon_app/Feature/Home/data/products_model/datum.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_cubit.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_states.dart';
import 'package:fashon_app/core/constans/end_point.dart';
import 'package:fashon_app/core/utils/colors.dart';
import 'package:fashon_app/core/utils/components.dart';
import 'package:fashon_app/core/utils/size_config.dart';
import 'package:fashon_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({super.key, required this.pro});
  Datum? pro;
  Color? colordata;
  double? price;

  @override
  Widget build(BuildContext context) {
    price = double.tryParse(pro!.price!);

    return BlocConsumer<HomeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Product"),
            centerTitle: true,
          ),
          body: ConditionalBuilder(
            condition: pro != null,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(18),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        width: double.infinity,
                        height: SizeConfig.screenHeight! * .40,
                        fit: BoxFit.cover,
                        imageUrl: "$IMGURL${pro?.img}",
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error_outline),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "${pro?.nameEn}",
                              style: StylesData.pageIteamDetails,
                            ),
                            const Spacer(),
                            Text(
                              "\$ ",
                              style: StylesData.pageIteamDetails.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: kMainColor),
                            ),
                            Text(
                              "${pro?.price}",
                              style: StylesData.pageIteamDetails
                                  .copyWith(fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${pro?.detailsEn}",
                        maxLines: 7,
                        overflow: TextOverflow.ellipsis,
                        style:
                            StylesData.TitleStyle.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (pro?.productAttributes?.isNotEmpty == true)
                        ConditionalBuilder(
                          condition: pro?.productAttributes!.isNotEmpty == true,
                          builder: (BuildContext context) {
                            if ((pro?.productAttributes?[0].color?.value
                                    ?.length) !=
                                7) {
                              colordata = const Color(0xff000000);
                            } else {
                              colordata = pro?.productAttributes?[0].color
                                          ?.value !=
                                      null
                                  ? Color(int.parse(
                                          '${pro?.productAttributes?[0].color?.value}'
                                              .substring(1, 7),
                                          radix: 16) +
                                      0xFF000000)
                                  : const Color(0xff000000);
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (pro?.productAttributes?[0].amount !=
                                    null) // const Spacer(),
                                  Text(
                                    "amount: ${pro?.productAttributes?[0].amount}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: StylesData.TitleStyle.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                const SizedBox(
                                  height: 10,
                                ),
                                if (pro?.productAttributes?[0].size?.nameEn !=
                                    null) // const Spacer(),
                                  Text(
                                    "Size: ${pro?.productAttributes?[0].size?.nameEn}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: StylesData.TitleStyle.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                const SizedBox(
                                  height: 10,
                                ),
                                if (pro?.productAttributes?[0].color !=
                                    null) // const Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                        "Color:",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: StylesData.TitleStyle.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor: colordata,
                                      )
                                    ],
                                  ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          },
                          fallback: (BuildContext context) {
                            return Container();
                          },
                        ),
                      //
                      if (pro?.productAttributes?.isEmpty == true)
                        //if (pro?.productAttributes == [])
                        SizedBox(
                          // height: 10,
                          child: Text(
                            "Not currently available, will be available soon",
                            style: StylesData.TitleStyle.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      const SizedBox(
                        height: 5,
                      ),
                      AddToCartButton(
                        actionAfterAdding: () {},
                        cartModel: CartItem(
                            id: pro!.id!,
                            name: pro!.nameEn!,
                            price: price!,
                            quantity: 1,
                            additionalData: {
                              'max': pro?.productAttributes?.isNotEmpty == true
                                  ? pro?.productAttributes![0].amount
                                  : 1
                            },
                            image: pro!.img!),
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "Add to cart",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
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
