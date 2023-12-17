import 'package:bloc/bloc.dart';
import 'package:fancy_cart/fancy_cart.dart';
import 'package:fashon_app/Feature/Home/data/brand_model/brand_model.dart';
import 'package:fashon_app/Feature/Home/data/category_model/category_model.dart';
import 'package:fashon_app/Feature/Home/data/city_model/city_model.dart';
import 'package:fashon_app/Feature/Home/data/count_model/count_model.dart';
import 'package:fashon_app/Feature/Home/data/fav_model/fav_model.dart';
import 'package:fashon_app/Feature/Home/data/products_model/products_model.dart';
import 'package:fashon_app/Feature/Home/data/profile_model/profile_model.dart';
import 'package:fashon_app/Feature/Home/data/slider_model/slider_model.dart';
import 'package:fashon_app/Feature/Home/presentation/manger/home_states.dart';
import 'package:fashon_app/Feature/Home/presentation/screens/shopping_cart.dart';
import 'package:fashon_app/Feature/Home/presentation/screens/fav_page.dart';
import 'package:fashon_app/Feature/Home/presentation/screens/profile.dart';
import 'package:fashon_app/Feature/Home/presentation/screens/main_home.dart';
import 'package:fashon_app/core/constans/end_point.dart';
import 'package:fashon_app/core/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitState());
  static HomeCubit get(context) => BlocProvider.of(context);
  ProductsModel? pro;
  String? countryName;
  String? cityName;

  void changecountrName({required String value}) {
    countryName = value;
    emit(ChangeNAmestate());
  }

  void changecityName({required String value}) {
    cityName = value;
    emit(ChangeNAmestate());
  }

  int? currentIndex = 0;
  void changeIndex({required value}) {
    emit(ChangeIndexLoading());
    currentIndex = value;
    if (value == 0) {
      getCategory();
      getSlider();
      getProduct(uId: UID).then((value) {
        emit(ChangeIndexSucc());
      });
    }
    if (value == 1) {
      getFav().then((value) {
        emit(ChangeIndexSucc());
      });
    }
  }

  List<String> headerName = [
    "Home",
    "Favorite",
    "shopping Cart",
    "Profile",
  ];

  Future<void> getProduct(
      {String? search, int? page, required int? uId}) async {
    pro = null;
    // favList = {};
    emit(GetProductLoading());
    DioHelper.getData(
        url: PRODUCT,
        query: {"search": search, "page": page, "user_id": uId}).then((value) {
      // print(value.data["status"]);

      pro = ProductsModel.fromJson(value.data);

      // print(pro!.status);
    }).then((value) {
      for (var element in pro!.data!.data!) {
        favList!.addAll({element.id: element.isFavorite == 0 ? false : true});
      }

      emit(GetProductSucc());

      // print(p[0].name);
    }).catchError((onError) {
      emit(GetProductError());

      // print(onError);
    });
  }

// TextEditingController searchController = TextEditingController();
  List<Widget> screens = [
    MainHome(
      searchController: TextEditingController(),
    ),
    const FavPage(),
    const ShoppingCart(
        // x: false,
        ),
    const Settings()
  ];
  SliderModel? slid;
  Future<void> getSlider() async {
    slid = null;
    emit(GetSliderLoading());
    DioHelper.getData(url: SLIDER).then((value) {
      // print(value.data["status"]);

      slid = SliderModel.fromJson(value.data);
      // print(slid!.result);
    }).then((value) {
      emit(GetSliderSucc());

      // print(p[0].name);
    }).catchError((onError) {
      emit(GetSliderError());

      // print(onError);
    });
  }

  // void start() {
  //   emit(GetStartLoading());
  //   getProduct().then((value) =>
  //       getSlider().then((value) => emit(GetStartSucc())).catchError((onError) {
  //         emit(GetStartError());
  //       }));
  // }
  CategoryModel? cat;
  void getCategory() {
    cat = null;

    emit(GetCategoryLoading());
    DioHelper.getData(
      url: CATEGORY,
    ).then((value) {
      // print("object ------------------- Is Value $value");
      cat = CategoryModel.fromJson(value.data);

      emit(GetCategorySucc());

      // print(value.data);
    }).catchError((error) {
      emit(GetCategoryError());
    });
  }

  BrandModel? brands;
  Future<void> getBrands() async {
    brands = null;
    emit(GetBrandsLoading());
    DioHelper.getData(url: BRAND).then((value) {
      // print(
      //     "value____________----------------------------________________- Is $value");
      brands = BrandModel.fromJson(value.data);
      // print("siu Yas Siu");
      // print(brands?.data!.length);
      // print("object");
      emit(GetBrandsSucc());
    }).catchError((error) {
      // print(error.toString());
      emit(GetBrandsError());
    });
  }

  Future<void> addOrRemoveFav({required int? id, bool indeta = false}) async {
    favList![id] = !favList![id]!;
    emit(AddOrRemoveFavLoading());

    DioHelper.postData(url: ADDORREMOVEFAV, token: TOKEN, data: {'favo_id': id})
        .then((value) {
      if (value.data['result'] == false) {
        favList![id] = !favList![id]!;
      }
      if (indeta) {
        getProduct(uId: UID);
      }

      // print(
      // "value _______________________________________________----------------------------_____________________________________ $value");
      emit(AddOrRemoveFavSucc(msq: value.data['error_mesage']));
    }).catchError((Error) {
      emit(AddOrRemoveFavError());
    });
  }

  IconData? favIcon = Icons.favorite;
  void changeIcon() {
    if (favIcon == Icons.favorite) {
      favIcon = Icons.favorite_border;
    } else {
      favIcon = Icons.favorite;
    }
    emit(ChangeFavIcon());
  }

  Future<void> getProfile() async {
    emit(GetProfileDataLoading());
    DioHelper.getData(url: PROFILE, token: TOKEN).then((value) {
      ProfileData = ProfileModel.fromJson(value.data);
      emit(GetProfileDataSucc());
    }).catchError((error) {
      emit(GetProfileDataError());
    });
  }

  FavModel? fav;
  Future<void> getFav() async {
    emit(GetFavProductLoading());
    DioHelper.getData(url: FAVORITE, token: TOKEN).then((value) {
      fav = FavModel.fromJson(value.data);
      emit(GetFavProductSucc());
    }).catchError((error) {
      emit(GetFavProductError());
    });
  }

  ProductsModel? searchProduct;

  void getProductByBrandAndCat({required int brandId, required int catId}) {
    searchProduct = null;
    emit(GetProductByBrandAndCatLoading());
    DioHelper.getData(
        url: 'products/t/ar/0/$catId/$brandId',
        query: {"user_id": UID}).then((value) {
      // print(value);
      searchProduct = ProductsModel.fromJson(value.data);
      for (var element in searchProduct!.data!.data!) {
        favList!.addAll({element.id: element.isFavorite == 0 ? false : true});
      }
      emit(GetProductByBrandAndCatSucc());
    }).catchError((onError) {
      emit(GetProductByBrandAndCatError());
    });
  }

  void editProfile(
      {required String user, required String phone, required String email}) {
    print(user);
    print(int.parse(phone));
    print(email);

    emit(EditProfileDataLoading());
    DioHelper.postData(
            url: UPDATEPROFILE,
            data: {
              'name': user,
              'mobile': phone,
              'email': email,
            },
            token: TOKEN)
        .then((value) {
      print(value);
      if (value.data['status'] == true) {
        emit(EditProfileDataSucc(msq: value.data['message']));
        getProfile();
      } else {
        emit(EditProfileDataError(msq: value.data['message']));
      }
    }).catchError((error) {
      emit(EditProfileDataError(msq: error.toString()));
    });
  }

  CountModel? count;
  Future<void> getCountry() async {
    emit(GetCountLoading());

    DioHelper.getData(url: COUNTRIES, token: TOKEN).then((value) {
      count = CountModel.fromJson(value.data);
      // city = null;
      emit(GetCountSucc());
    }).catchError((onError) {
      emit(GetCountError(msq: onError.toString()));
    });
  }

  CityModel? city;
  Future<void> getCities({required int id}) async {
    emit(GetcityLoading());

    DioHelper.getData(url: 'cities', token: TOKEN, data: {'country_id': id})
        .then((value) {
      city = CityModel.fromJson(value.data);
      emit(GetcitySucc());
    }).catchError((onError) {
      emit(GetcityError(msq: onError.toString()));
    });
  }

  Future<void> UserOrder(
      {required double total_price, required List<CartItem> pro}) async {
    emit(OrderUserLoading());
    // ignore: non_constant_identifier_names
    List<Map<String, int>?> x = [];
    for (var e in pro) {
      x.add({
        "product_id": e.id,
        "price": e.price.toInt(),
        'quantity': e.quantity
      });
    }
    DioHelper.postData(url: 'user_orders', token: TOKEN, data: {
      "order_total_price": total_price,
      "coupon_discount": 0,
      "payment_type": "online_payment",
      "coupon_id": 10,
      "user_notes": "fdljoi5j4jforoi5",
      "products": x,
    }).then((value) {
      emit(OrderUserSucc(msq: value.data['error_mesage_en']));
    }).catchError((error) {
      emit(OrderUserError(msq: error.toString()));
    });
  }
}
