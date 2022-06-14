import 'package:flutter/material.dart';
import 'package:pet_shop_app/models/pet_list.dart';
import 'package:pet_shop_app/models/vet_list.dart';
import 'package:pet_shop_app/pages/pet_detail_page.dart';
import 'package:pet_shop_app/pages/pet_form_page.dart';
import 'package:pet_shop_app/pages/pet_management_page.dart';
import 'package:pet_shop_app/pages/pet_shop_main_page.dart';
import 'package:pet_shop_app/pages/vet_detail_page.dart';
import 'package:pet_shop_app/pages/vet_form_page.dart';
import 'package:pet_shop_app/pages/vet_management_page.dart';
import 'package:pet_shop_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   Widget bottoNavigator() => BottomNavigationBar(
				currentIndex: _indiceAtual,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.pets),
              label: "Pets"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.medical_services),
              label: "Veterinários"
          ),
        ],
  );

  int _indiceAtual = 1;

  final List<Widget> _telas = [
    PetManagementPage(),
    PetShopMainPage(),
    VetManagementPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
       providers: [
        ChangeNotifierProvider<PetList>(create: (_) => PetList()),
        ChangeNotifierProvider<VetList>(create: (_) => VetList()),
      ],
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
            fontFamily: 'Lato',
            //primarySwatch: Colors.pink,
            colorScheme: ThemeData().copyWith().colorScheme.copyWith(
                primary: Colors.blue, secondary: Colors.orangeAccent)),
        home: Scaffold(
          bottomNavigationBar: bottoNavigator(),
          body: _telas[_indiceAtual],
      ),
        routes: {
          AppRoutes.PET_DETAIL: (ctx) => PetDetailPage(),
          AppRoutes.PET_FORM: (context) => PetFormPage(),
          AppRoutes.PET_MANAGEMENT: (context) => PetManagementPage(),
          AppRoutes.VET_FORM: (context) => VetFormPage(),
          AppRoutes.VET_DETAIL: (ctx) => VetDetailPage(),
          AppRoutes.VET_MANAGEMENT:(context) => VetManagementPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}