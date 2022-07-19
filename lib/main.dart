import 'package:flutter/material.dart';
import 'package:pet_shop_app/firebase_options.dart';
import 'package:pet_shop_app/models/pet_list.dart';
import 'package:pet_shop_app/models/vet_list.dart';
import 'package:pet_shop_app/pages/pet_management_page.dart';
import 'package:pet_shop_app/pages/pet_shop_main_page.dart';
import 'package:pet_shop_app/pages/vet_management_page.dart';
import 'package:pet_shop_app/services/firebase_mensaging_services.dart';
import 'package:pet_shop_app/services/flutter_notifications.dart';
import 'package:pet_shop_app/utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  name: 'pet-shop',
  options: DefaultFirebaseOptions.currentPlatform,
  ).whenComplete(() {
    print("completedAppInitialize");
  });

  runApp(MyApp());

  
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    initilizeFirebaseMessaging();
    checkNotifications();
  }

  initilizeFirebaseMessaging() async {
    await Provider.of<FirebaseMessagingService>(context, listen: false).initialize();
  }

  checkNotifications() async {
    await Provider.of<NotificationService>(context, listen: false).checkForNotifications();
  }

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
        Provider<FirebaseMessagingService>(
          create: (context) => FirebaseMessagingService(context.read<NotificationService>()),
        ),
      ],
      child: MaterialApp(
        title: 'Pet Shop',
        theme: ThemeData(
            fontFamily: 'Lato',
            //primarySwatch: Colors.pink,
            colorScheme: ThemeData().copyWith().colorScheme.copyWith(
                primary: Colors.blue, secondary: Colors.orangeAccent)),
        home: Scaffold(
          bottomNavigationBar: bottoNavigator(),
          body: _telas[_indiceAtual],
      ),
        routes: Routes.list,
        debugShowCheckedModeBanner: false,
    ),
    );
  }
}