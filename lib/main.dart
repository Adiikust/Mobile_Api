import 'dart:io';
import 'package:hive_flutter/adapters.dart';
import 'package:mobile_api/Controller/Export/export_screen.dart';
import 'package:mobile_api/Views/Delivery/delivery_Screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  await Hive.openBox<String>("Adnan");
  await Hive.openBox('isUserLogin');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Api',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: ValueListenableBuilder(
        valueListenable: Hive.box('isUserLogin').listenable(),
        builder: (BuildContext context, Box box, Widget? child) => box.get(
          'isUserLoggedIn',
          defaultValue: false,
        )
            ? DeliveryScreen()
            : const LoginScreen(),
      ),
    );
  }
}
