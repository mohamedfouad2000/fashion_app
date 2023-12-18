import 'package:fashon_app/Feature/Boarding/presentation/widgets/page_view_iteam.dart';
import 'package:fashon_app/core/utils/assets_data.dart';
import 'package:flutter/material.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({super.key, required this.pageviewcontroller});
  final PageController pageviewcontroller;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageviewcontroller,
      children: [
        pageViewItem(
            image: AssetsData.onboarding1,
            title: "Fashon App",
            details: "Explore the best clothes and the latest fashion trends"),
        pageViewItem(
            image: AssetsData.onboarding2,
            title: "Delivery on the way",
            details: "Get your order delivered with fast delivery"),
        pageViewItem(
            image: AssetsData.onboarding3,
            title: "Delivery Arrived",
            details: 'Order is arrived at your Place'),
      ],
    );
  }
}
