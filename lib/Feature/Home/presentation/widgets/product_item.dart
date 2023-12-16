import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashon_app/Feature/Home/data/products_model/datum.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_cubit.dart';
import 'package:fashon_app/Feature/Home/presentation/screens/details.dart';
import 'package:fashon_app/core/constans/end_point.dart';
import 'package:fashon_app/core/utils/colors.dart';
import 'package:fashon_app/core/utils/components.dart';
import 'package:fashon_app/core/utils/size_config.dart';
import 'package:fashon_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

Widget proItem({required Datum? pro, required context}) {
  print(pro?.id);
  return Padding(
    padding: const EdgeInsets.only(bottom: 4, right: 4, top: 4, left: 4),
    child: InkWell(
      onTap: () {},
      child: Container(
        // width: 200,
        // height: SizeConfig.screenHeight! * 35.0,
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
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              NavegatorPush(
                  context,
                  DetailsPage(
                    pro: pro,
                  ));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional.center,
                  child: CachedNetworkImage(
                    height: SizeConfig.screenHeight! * .18,
                    // height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: "$IMGURL${pro?.img}",
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error_outline),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${pro?.nameEn}',
                  style: StylesData.pageIteamDetails,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const Spacer(),
                pro?.productAttributes?.isNotEmpty == true
                    ? Text("Available is ${pro?.productAttributes?[0].amount}",
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w600))
                    : const Text(
                        "Not Available Now",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w600),
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
                      "${pro?.price}",
                      style: StylesData.pageIteamDetails
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        HomeCubit.get(context)
                            .addOrRemoveFav(id: pro?.id)
                            .then((value) {
                          print("object");
                        });
                      },
                      icon: favList?[pro?.id] == true
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border),
                      color: Colors.red,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
