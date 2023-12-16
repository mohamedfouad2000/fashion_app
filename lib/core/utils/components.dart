import 'package:fancy_cart/fancy_cart.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_cubit.dart';
import 'package:fashon_app/Feature/Login/presentation/login_page.dart';
import 'package:fashon_app/core/constans/end_point.dart';
import 'package:fashon_app/core/local/cache_Helper.dart';
import 'package:fashon_app/core/utils/colors.dart';
import 'package:fashon_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:ecommers/core/utils/size_config.dart';
// import 'package:ecommers/core/utils/size_config.dart';

Widget defaultButton({required VoidCallback fun, required String text}) =>
    Container(
      decoration: BoxDecoration(
          color: kMainColor, borderRadius: BorderRadius.circular(20)),
      height: 60,
      width: double.infinity,
      child: TextButton(
        onPressed: fun,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget customTextFiled(
        {required TextEditingController controller,
        required TextStyle textstyle,
        TextInputType type = TextInputType.name,
        var ontapFun,
        bool enabled = true,
        int maxLines = 1}) =>
    TextField(
      enabled: enabled,
      controller: controller,
      onTap: ontapFun,
      onSubmitted: (v) {
        ontapFun;
      },
      maxLines: maxLines,
      keyboardType: type,
      style: textstyle,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),

        // labelText: 'Password',
      ),
    );
Widget customTextFormedFiled({
  required controller,
  TextInputType type = TextInputType.name,
  IconData? preicon,
  bool obscureText = false,
  String val = "",
  var sufficon,
  required String hintText,
  var sufFunction,
}) =>
    TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: type,
      validator: (value) {
        if (value != null && value.isEmpty) {
          return val;
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),

        hintText: hintText,

        prefixIcon: Icon(
          preicon,
          color: Colors.grey,
        ),

        suffixIcon: sufficon != null
            ? InkWell(
                onTap: () {
                  sufFunction();
                },
                child: Icon(sufficon))
            : null,

        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),

        // labelText: 'Password',
      ),
    );

enum SelectToast { succ, eroor, warning }

Color selectColor({required SelectToast n}) {
  Color? color;
  switch (n) {
    case SelectToast.eroor:
      color = Colors.red;
      break;
    case SelectToast.succ:
      color = Colors.amber;
      break;

    case SelectToast.warning:
      color = Colors.green;
  }
  return color;
}

Future<void> showToast({
  required msg,
  required SelectToast n,
}) async =>
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
      gravity: ToastGravity.BOTTOM,
    );

NavegatorPush(context, page) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (builder) => page),
  );
}

Nav(context, page) {
  return Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (builder) => page), (route) => false);
}

Widget eroorFieds() => Container(
      width: double.infinity,
      height: 30,
      color: Colors.red,
      child: Text(
        "Please Enter All Fileds ",
        style: StylesData.titleInfo.copyWith(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );

Widget textFileldSearch(
    {required TextEditingController? searchController, required context}) {
  return TextField(
    controller: searchController,
    onChanged: (String s) {
      if (s.isNotEmpty) {
        HomeCubit.get(context).getProduct(search: s, uId: UID);
      } else {
        HomeCubit.get(context).getProduct(uId: UID);
      }
    },
    // obscureText: true,
    decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              // width: 3,
              color: Color.fromARGB(255, 212, 210, 210)),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ), //<-- SEE HERE
        ),

        // labelText: 'Search',
        hintText: 'Search item',
        prefixIcon: Icon(
          Icons.search,
          size: 30,
        )),
  );
}

AppBar mainAppBar({required context}) => AppBar(
      // elevation: 20.0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              IconButton(
                onPressed: () {
                  HomeCubit.get(context).changeIndex(value: 2);
                },
                icon: const Image(
                  image: AssetImage(
                    'assets/img/shoping.png',
                  ),
                  height: 50,
                ),
              ),
              CircleAvatar(
                radius: 10,
                backgroundColor: const Color.fromARGB(255, 218, 90, 81),
                child: TotalItemsCartWidget(
                  totalItemsBuilder: (int totalItems) {
                    return Text(
                      "$totalItems",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    );
                  },
                ),
              )
            ],
          ),
        )
      ],
    );

Widget myDrawerList(context) {
  return Padding(
    padding: const EdgeInsets.only(top: 15.0),
    child: Column(
      children: [
        menuItem(1, 'Home', Icons.home_outlined, context),
        menuItem(2, 'favorites', Icons.favorite, context),
        menuItem(3, 'shopping car', Icons.shopping_cart, context),
        menuItem(4, 'Profile', Icons.person, context),
        menuItem(5, 'Log Out', Icons.logout, context),
      ],
    ),
  );
}

Widget menuItem(int id, String title, IconData icon, context) {
  return Material(
    child: InkWell(
      onTap: () {
        if (id == 1) {
          Navigator.pop(context);

          HomeCubit.get(context).changeIndex(value: 0);
        }

        if (id == 2) {
          Navigator.pop(context);

          HomeCubit.get(context).changeIndex(value: 1);

          // NavegatorPush(context, ContactUS());
        }

        if (id == 3) {
          Navigator.pop(context);

          HomeCubit.get(context).changeIndex(value: 2);

          // casheHelber.removeData(key: 'uId').then((value) {
          // Nav(context, loginscreen());
          // });
        }
        if (id == 4) {
          Navigator.pop(context);
          HomeCubit.get(context).changeIndex(value: 3);

          // NavegatorPush(context, yourcomplaints());
        }
        if (id == 5) {
          CacheHelper.removeData(key: 'Token').then((value) {
            Nav(context, const LoginPage());
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                icon,
                size: 20.0,
                color: Colors.grey,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget header(context) => Container(
      color: Colors.blueAccent,
      width: double.infinity,
      height: 200.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                // NavegatorPush(context, const userprofile());
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                height: 90.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  // backgroundColor: Colors.red,

                  radius: 40,
                  backgroundImage: NetworkImage(
                    "$IMGURL ${ProfileData?.data?.profilePhotoPath}",
                  ),
                ),
              ),
            ),
            Text(
              '${ProfileData?.data?.name}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            Text(
              '${ProfileData?.data?.email}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
