import 'package:fashon_app/core/utils/size_config.dart';
import 'package:fashon_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget pageViewItem(
        {required String image,
        required String? title,
        required String? details}) =>
    Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: SizeConfig.screenHeight! * .20,
        ),
        SizedBox(
            height: SizeConfig.screenHeight! * .30, child: Lottie.asset(image)),
        const SizedBox(
          height: 15,
        ),
        Text(
          title!,
          style: StylesData.pageiteamtitle,
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          details!,
          style: StylesData.pageIteamDetails,
        ),
      ],
    );
