import 'package:cached_network_image/cached_network_image.dart';
import 'package:fancy_cart/fancy_cart.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_cubit.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_states.dart';
import 'package:fashon_app/Feature/Home/presentation/screens/order.dart';
import 'package:fashon_app/core/constans/end_point.dart';
import 'package:fashon_app/core/utils/colors.dart';
import 'package:fashon_app/core/utils/components.dart';
import 'package:fashon_app/core/utils/size_config.dart';
import 'package:fashon_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});
  @override
  Widget build(BuildContext context) {
    List<CartItem>? cartList;

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
// ignore: unnecessary_null_comparison
                        controller.cartList[index] == null;

                        final cartItem = controller.cartList[index];
                        cartList = controller.cartList;
                        // cardInt = controller.cartList.length;
                        print(cartItem.additionalData);

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
                                          cartItem.additionalData['details'] !=
                                                  ''
                                              ? Text(
                                                  "${cartItem.additionalData['details']}",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: StylesData.TitleStyle
                                                      .copyWith(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                )
                                              : Text(
                                                  cartItem.additionalData[
                                                                  'details'] ==
                                                              '' &&
                                                          cartItem.additionalData[
                                                                  'amount'] ==
                                                              ''
                                                      ? "Not currently available, will be available soon"
                                                      : '',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                          if (cartItem
                                                  .additionalData['amount'] !=
                                              null)
                                            Text(
                                              "amount: ${cartItem.additionalData['amount']}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: StylesData.TitleStyle
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          // const Spacer(),
                                          if (cartItem.additionalData['size'] !=
                                              '')
                                            Text(
                                              "Size: ${cartItem.additionalData['size']}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: StylesData.TitleStyle
                                                  .copyWith(
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
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 15.0,
                                          backgroundColor: Colors.blue,
                                          child: IconButton(
                                            onPressed: () {
                                              if (cartItem.quantity ==
                                                  int.parse(cartItem
                                                      .additionalData['max'])) {
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
                                              controller.decrementItemQuantity(
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
                if (controller.getTotalPrice() == 0.0) const Spacer(),
                if (controller.getTotalPrice() == 0.0)
                  Center(
                      child: SizedBox(
                          child: Lottie.asset('assets/img/cartemp.json'))),
                if (controller.getTotalPrice() == 0.0) const Spacer(),
                if (controller.getTotalPrice() != 0.0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total Price : \$ ${controller.getTotalPrice()}",
                        style: StylesData.TitleStyle.copyWith(fontSize: 16),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          NavegatorPush(
                              context,
                              OrderPage(
                                cartList: cartList,
                                totalPrice: controller.getTotalPrice(),
                              ));
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
                              "Order now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  // letterSpacing: 2.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
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
