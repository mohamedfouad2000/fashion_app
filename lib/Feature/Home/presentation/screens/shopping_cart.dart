import 'package:cached_network_image/cached_network_image.dart';
import 'package:fancy_cart/fancy_cart.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_cubit.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_states.dart';
import 'package:fashon_app/core/constans/end_point.dart';
import 'package:fashon_app/core/utils/colors.dart';
import 'package:fashon_app/core/utils/size_config.dart';
import 'package:fashon_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return CartWidget(
          cartBuilder: (controller) {
            return Column(
              children: [
                if (controller.getTotalPrice() != 0.0)
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.cartList.length,
                      itemBuilder: (context, index) {
                        final cartItem = controller.cartList[index];
                        // cardInt = controller.cartList.length;
                        return Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Padding(
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
                                    CachedNetworkImage(
                                      height: SizeConfig.screenHeight! * .18,
                                      // height: SizeConfig.screenHeight! * .25,
                                      width: SizeConfig.screenWidth! * .30,
                                      fit: BoxFit.cover,
                                      imageUrl: "$IMGURL${cartItem.image}",
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error_outline),
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
                                            cartItem.name,
                                            style: StylesData.pageIteamDetails
                                                .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 15.0,
                                                backgroundColor: Colors.blue,
                                                child: IconButton(
                                                  onPressed: () {
                                                    if (cartItem.quantity ==
                                                        int.parse(cartItem
                                                                .additionalData[
                                                            'max'])) {
                                                    } else {
                                                      controller
                                                          .incrementItemQuantity(
                                                        cartItem,
                                                      );
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.add,
                                                    size: 15.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                cartItem.quantity.toString(),
                                                style: StylesData.TitleStyle,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              // if (cartItem.quantity != 1)
                                              CircleAvatar(
                                                radius: 15.0,
                                                backgroundColor: Colors.blue,
                                                child: IconButton(
                                                  onPressed: () {
                                                    controller
                                                        .decrementItemQuantity(
                                                            cartItem);
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove,
                                                    size: 15.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              // const Spacer(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.remove_circle_rounded,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                controller.removeItem(cartItem);
                              },
                            ),
                            Positioned(
                              bottom: 20,
                              right: 10,
                              child: Row(
                                children: [
                                  Text(
                                    "\$",
                                    style: StylesData.pageIteamDetails.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: kMainColor),
                                  ),
                                  Text(
                                    "${cartItem.price * cartItem.quantity}",
                                    style: StylesData.pageIteamDetails.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),

                // ----------------- add to cart button ----------------- //
                /// add to cart button with action after add and model to add
                ///
                if (controller.getTotalPrice() == 0.0)
                  Center(
                      child: SizedBox(
                          child: Lottie.asset('assets/img/cartemp.json'))),
                if (controller.getTotalPrice() != 0.0)
                  Text(
                    "Total Price : \$ ${controller.getTotalPrice()}",
                    style: StylesData.TitleStyle.copyWith(fontSize: 16),
                  ),
              ],
            );
          },
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
