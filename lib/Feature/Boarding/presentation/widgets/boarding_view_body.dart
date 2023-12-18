import 'package:dots_indicator/dots_indicator.dart';
import 'package:fashon_app/Feature/Boarding/presentation/widgets/custom_page_view.dart';
import 'package:fashon_app/Feature/Login/presentation/login_page.dart';
import 'package:fashon_app/core/local/cache_Helper.dart';
import 'package:flutter/material.dart';
import 'package:fashon_app/core/utils/colors.dart';
import 'package:fashon_app/core/utils/components.dart';
import 'package:fashon_app/core/utils/size_config.dart';

class BoardingViewBody extends StatefulWidget {
  const BoardingViewBody({super.key});

  @override
  State<BoardingViewBody> createState() => _BoardingViewBodyState();
}

class _BoardingViewBodyState extends State<BoardingViewBody> {
  PageController? pageController;
  int? index;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(
      initialPage: 0,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Stack(
        children: [
          CustomPageView(
            pageviewcontroller: pageController!,
          ),
          Positioned(
            bottom: SizeConfig.defaultSize! * 15,
            left: 0,
            right: 0,
            child: DotsIndicator(
              dotsCount: 3,
              onTap: (i) {
                // print(i);
              },
              position: pageController!.hasClients
                  ? pageController!.page!.toInt()
                  : 0,

              // position: widget.index!,
              decorator: const DotsDecorator(activeColor: kMainColor),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * .07,
              right: 20,
              child: Visibility(
                visible: pageController!.hasClients && pageController!.page == 2
                    ? false
                    : true,
                child: TextButton(
                  onPressed: () {
                    CacheHelper.setBoolean(key: "Boarding", value: true)
                        .then((value) => {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      const LoginPage(),
                                  transitionDuration:
                                      const Duration(seconds: 2),
                                  transitionsBuilder: (_, a, __, c) =>
                                      FadeTransition(opacity: a, child: c),
                                ),
                              )
                            });
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontFamily: 'poppins'),
                    textAlign: TextAlign.right,
                  ),
                ),
              )),
          Positioned(
              // top: SizeConfig.defaultSize! * 10,
              left: SizeConfig.defaultSize! * 10,
              right: SizeConfig.defaultSize! * 10,
              bottom: SizeConfig.defaultSize! * 7,
              child: defaultButton(
                  fun: () {
                    if (pageController!.hasClients) {
                      if (pageController!.page! < 2) {
                        pageController!.nextPage(
                            duration: const Duration(microseconds: 8000),
                            curve: Curves.easeInCirc);
                      } else {
                        CacheHelper.setBoolean(key: "Boarding", value: true)
                            .then((value) => {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                          const LoginPage(),
                                      transitionDuration:
                                          const Duration(seconds: 2),
                                      transitionsBuilder: (_, a, __, c) =>
                                          FadeTransition(opacity: a, child: c),
                                    ),
                                  )
                                });
                      }
                    }
                  },
                  text: pageController!.hasClients && pageController!.page == 2
                      ? "Get Start"
                      : "Next")),
        ],
      ),
    );
  }
}
