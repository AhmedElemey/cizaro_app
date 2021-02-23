import 'dart:io';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:cizaro_app/screens/aboutUs_screen.dart';
import 'package:cizaro_app/screens/add_address_screen.dart';
import 'package:cizaro_app/screens/addressbook_screen.dart';
import 'package:cizaro_app/screens/checkout_screen.dart';
import 'package:cizaro_app/screens/contactUs_screen.dart';
import 'package:cizaro_app/screens/edit_address_screen.dart';
import 'package:cizaro_app/screens/favorite_screen.dart';
import 'package:cizaro_app/screens/finished_order_screen.dart';
import 'package:cizaro_app/screens/home_screen.dart';
import 'package:cizaro_app/screens/login_screen.dart';
import 'package:cizaro_app/screens/mycart_screen.dart';
import 'package:cizaro_app/screens/orders_screen.dart';
import 'package:cizaro_app/screens/payments_screen.dart';
import 'package:cizaro_app/screens/pending_shipment_screen.dart';
import 'package:cizaro_app/screens/policesTerms_screen.dart';
import 'package:cizaro_app/screens/product_details.dart';
import 'package:cizaro_app/screens/profileEdit_screen.dart';
import 'package:cizaro_app/screens/profile_screen.dart';
import 'package:cizaro_app/screens/searchBar_screen.dart';
import 'package:cizaro_app/screens/search_screen.dart';
import 'package:cizaro_app/screens/shop_screen.dart';
import 'package:cizaro_app/screens/splash_screen.dart';
import 'package:cizaro_app/screens/tabs_screen.dart';
import 'package:cizaro_app/services/auth_service.dart';
import 'package:cizaro_app/view_model/auth_view_model.dart';
import 'package:cizaro_app/view_model/cart_view_model.dart';
import 'package:cizaro_app/view_model/fav_iew_model.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/view_model/orders_view_model.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class AppleSignInAvailable {
  AppleSignInAvailable(this.isAvailable);
  final bool isAvailable;

  static Future<AppleSignInAvailable> check() async {
    return AppleSignInAvailable(await AppleSignIn.isAvailable());
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appleSignInAvailable = await AppleSignInAvailable.check();
  runApp(
    MultiProvider(
      providers: [
        Provider<AppleSignInAvailable>.value(value: appleSignInAvailable),
        ChangeNotifierProvider.value(value: AuthViewModel()),
        ChangeNotifierProvider.value(value: ListViewModel()),
        ChangeNotifierProvider.value(value: CartViewModel()),
        ChangeNotifierProvider.value(value: FavViewModel()),
        ChangeNotifierProvider.value(value: OrdersViewModel())
      ],
      child: DevicePreview(
        enabled: false,
        builder: (context) => Provider<AuthServices>(
          create: (_) => AuthServices(),
          child: MaterialApp(
            navigatorKey: mainNavigatorKey,
            builder: DevicePreview.appBuilder,
            theme: ThemeData(
                primaryColor: Color(0xff294794),
                splashColor: Colors.transparent),
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
            routes: {
              TabsScreen.routeName: (ctx) => TabsScreen(),
              LoginScreen.routeName: (ctx) => LoginScreen(),
              HomeScreen.routeName: (ctx) => HomeScreen(),
              ProfileScreen.routeName: (ctx) => ProfileScreen(),
              AddressBookScreen.routeName: (ctx) => AddressBookScreen(),
              ProductDetails.routeName: (ctx) => ProductDetails(),
              FavoriteScreen.routeName: (ctx) => FavoriteScreen(),
              MyCartScreen.routeName: (ctx) => MyCartScreen(),
              ShopScreen.routeName: (ctx) => ShopScreen(),
              CheckoutScreen.routeName: (ctx) => CheckoutScreen(),
              SearchScreen.routeName: (ctx) => SearchScreen(),
              ContactUsScreen.routeName: (ctx) => ContactUsScreen(),
              SearchBarScreen.routeName: (ctx) => SearchBarScreen(),
              AboutUsScreen.routeName: (ctx) => AboutUsScreen(),
              PolicesTermsScreen.routeName: (ctx) => PolicesTermsScreen(),
              AddAddressScreen.routeName: (ctx) => AddAddressScreen(),
              ProfileEditScreen.routeName: (ctx) => ProfileEditScreen(),
              OrderScreen.routeName: (ctx) => OrderScreen(),
              PendingShipment.routeName: (ctx) => PendingShipment(),
              FinishedOrder.routeName: (ctx) => FinishedOrder(),
              EditAddressScreen.routeName: (ctx) => EditAddressScreen(),
              PaymentsScreen.routeName: (ctx) => PaymentsScreen()
            },
          ),
        ),
      ),
    ),
  );
}
