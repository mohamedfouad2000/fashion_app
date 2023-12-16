// import 'package:fancy_cart/fancy_cart.dart';
import 'package:fancy_cart/fancy_cart.dart';
import 'package:fashon_app/Feature/Home/data/profile_model/profile_model.dart';
import 'package:fashon_app/Feature/Register/data/user_model/user_model.dart';

const PRODUCT = 'products/t/ar/0/0/0';
const SLIDER = 'gallery/t/en/1';
const IMGURL = 'https://fashionzone.masool.net/uploads/';
const REGISTERURL = 'register';
const LOGINURL = 'login';
const BRAND = 'categories/get_with_sub/ar/1/0';
String? TOKEN = '';
UserModel? USERMODEL;
const CATEGORY = 'categories/t/en/0/1';
const ADDORREMOVEFAV = 'user_favorite';
const PROFILE = 'profile';
ProfileModel? ProfileData;
// const BRAND ='categories/t/ar/1/0';
int? UID;
const FAVORITE = 'user_favorite/t/ar';

const ADDORDELETINCAR = 'addOrDelet_incar';

Map<int?, bool?>? favList = {};
// List<CartItem> cartList = [];

List<CartItem> cartList = [];

int? cardInt;
