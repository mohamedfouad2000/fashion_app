import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fancy_cart/fancy_cart.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_cubit.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_states.dart';
import 'package:fashon_app/core/constans/end_point.dart';
import 'package:fashon_app/core/utils/components.dart';
import 'package:fashon_app/core/utils/size_config.dart';
import 'package:fashon_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class OrderPage extends StatelessWidget {
  // ignore: non_constant_identifier_names
  OrderPage({super.key, required this.cartList, required this.totalPrice});
  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  List<CartItem>? cartList;
  int? countId;
  double? totalPrice;

  @override
  Widget build(BuildContext context) {
    HomeCubit.get(context).getCountry().then((value) {});
    HomeCubit.get(context).countryName = null;
    HomeCubit.get(context).cityName = null;
    HomeCubit.get(context).city = null;
    cartList?.forEach((element) {});
    return BlocConsumer<HomeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: mainAppBar(context: context, cart: false, x: "Order"),
          body: ConditionalBuilder(
            condition: HomeCubit.get(context).count != null,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(15),
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Colors.grey.withOpacity(0.5),
                    //           spreadRadius: 3,
                    //           blurRadius: 10,
                    //           offset: const Offset(0, 3),
                    //         ),
                    //       ]),
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 10),
                    //     child: Column(
                    //       children: [
                    //         if (HomeCubit.get(context).countryName == null)
                    //           Row(
                    //             children: [
                    //               const Text(
                    //                 "Select Country",
                    //                 style: StylesData.TitleStyleColor,
                    //               ),
                    //               const SizedBox(
                    //                 width: 15,
                    //               ),
                    //               DropdownButton<String>(
                    //                 value: HomeCubit.get(context).countryName,
                    //                 onChanged: (String? value) {
                    //                   HomeCubit.get(context)
                    //                       .changecountrName(value: value!);
                    //                   for (var element in HomeCubit.get(context)
                    //                       .count!
                    //                       .data!
                    //                       .countries!) {
                    //                     if (element.nameEn ==
                    //                         HomeCubit.get(context)
                    //                             .countryName) {
                    //                       HomeCubit.get(context)
                    //                           .getCities(id: element.id!)
                    //                           .then((v) {});
                    //                     }
                    //                   }

                    //                   // This is called when the user selects an item.
                    //                   // setState(() => selectedItem = value!);
                    //                 },
                    //                 items: HomeCubit.get(context)
                    //                     .count!
                    //                     .data!
                    //                     .countries!
                    //                     .map((Country item) =>
                    //                         DropdownMenuItem<String>(
                    //                           value: item.nameEn,
                    //                           child: Text(
                    //                             item.nameEn.toString(),
                    //                             style: const TextStyle(
                    //                               fontSize: 14,
                    //                               fontWeight: FontWeight.bold,
                    //                               color: Colors.black,
                    //                             ),
                    //                             overflow: TextOverflow.ellipsis,
                    //                           ),
                    //                         ))
                    //                     .toList(),
                    //               ),
                    //             ],
                    //           ),
                    //         const SizedBox(
                    //           height: 5,
                    //         ),
                    //         if (HomeCubit.get(context).city != null)
                    //           Row(
                    //             children: [
                    //               const Text(
                    //                 "Select city",
                    //                 style: StylesData.TitleStyleColor,
                    //               ),
                    //               const SizedBox(
                    //                 width: 15,
                    //               ),
                    //               DropdownButton<String>(
                    //                 value: HomeCubit.get(context).cityName,
                    //                 onChanged: (String? value) {
                    //                   HomeCubit.get(context)
                    //                       .changecityName(value: value!);
                    //                   // This is called when the user selects an item.
                    //                   // setState(() => selectedItem = value!);
                    //                 },
                    //                 items: HomeCubit.get(context)
                    //                     .city!
                    //                     .data!
                    //                     .countricities!
                    //                     .map<DropdownMenuItem<String>>(
                    //                         (Countricity item) {
                    //                   return DropdownMenuItem<String>(
                    //                     value: item.name,
                    //                     child: Text(item.name.toString()),
                    //                   );
                    //                 }).toList(),
                    //               ),
                    //             ],
                    //           ),
                    //         const SizedBox(
                    //           height: 10,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Products",
                      style: StylesData.TitleStyleColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              height: SizeConfig.screenHeight! * .24,
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
                                  Stack(
                                    children: [
                                      CachedNetworkImage(
                                        height: SizeConfig.screenHeight! * .18,
                                        // height: SizeConfig.screenHeight! * .25,
                                        width: SizeConfig.screenWidth! * .30,
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            "$IMGURL${cartList![index].image}",
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error_outline),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartList![index].name,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          style: StylesData.pageIteamDetails
                                              .copyWith(
                                            // fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        cartList![index].additionalData[
                                                    'details'] !=
                                                ''
                                            ? Text(
                                                "${cartList![index].additionalData['details']}",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: StylesData.TitleStyle
                                                    .copyWith(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              )
                                            : Text(
                                                cartList![index].additionalData[
                                                                'details'] ==
                                                            '' &&
                                                        cartList![index]
                                                                    .additionalData[
                                                                'amount'] ==
                                                            ''
                                                    ? "Not currently available, will be available soon"
                                                    : '',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: StylesData.TitleStyle
                                                    .copyWith(
                                                        fontSize: 16,
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        if (cartList![index]
                                                .additionalData['amount'] !=
                                            null)
                                          Text(
                                            "amount: ${cartList![index].additionalData['amount']}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                StylesData.TitleStyle.copyWith(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        // const Spacer(),
                                        if (cartList![index]
                                                .additionalData['size'] !=
                                            '')
                                          Text(
                                            "Size: ${cartList![index].additionalData['size']}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                StylesData.TitleStyle.copyWith(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total Price : \$ $totalPrice",
                          style: StylesData.TitleStyle.copyWith(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {},
                          child: ClearCartButton(
                            actionAfterDelete: () {
                              HomeCubit.get(context)
                                  .UserOrder(
                                      total_price: totalPrice!, pro: cartList!)
                                  .then((value) {
                                log("cart deleted", name: "cart deleted");
                              });
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.lightBlue,
                                      Colors.blue,
                                      Colors.blueAccent,
                                      Colors.lightBlue
                                    ]),
                                borderRadius: BorderRadius.circular(80.0),
                              ),
                              child: Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 120.0,
                                  maxHeight: 60.0,
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "Accept Order",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      // letterSpacing: 2.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
        if (state is GetCountError) {
          showToast(msg: state.msq, n: SelectToast.eroor).then((value) {
            Navigator.pop(context);
          });
        }
        if (state is OrderUserSucc) {
          Navigator.pop(context);
          showToast(msg: state.msq, n: SelectToast.eroor);
        }
        if (state is OrderUserError) {
          showToast(msg: state.msq, n: SelectToast.eroor);

          Navigator.pop(context);
        }
      },
    );
  }
}
