import 'package:flutter/material.dart';
import 'package:pet_shop_app/pages/pet_detail_page.dart';
import 'package:pet_shop_app/pages/pet_form_page.dart';
import 'package:pet_shop_app/pages/pet_management_page.dart';
import 'package:pet_shop_app/pages/vet_detail_page.dart';
import 'package:pet_shop_app/pages/vet_form_page.dart';
import 'package:pet_shop_app/pages/vet_management_page.dart';
import 'package:pet_shop_app/utils/app_routes.dart';


class Routes {
  static Map<String, Widget Function(BuildContext)> list = <String, WidgetBuilder>{
    AppRoutes.PET_DETAIL: (ctx) => PetDetailPage(),
    AppRoutes.PET_FORM: (context) => PetFormPage(),
    AppRoutes.PET_MANAGEMENT: (context) => PetManagementPage(),
    AppRoutes.VET_FORM: (context) => VetFormPage(),
    AppRoutes.VET_DETAIL: (ctx) => VetDetailPage(),
    AppRoutes.VET_MANAGEMENT:(context) => VetManagementPage(),
  };

  static String initial = '/home';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}