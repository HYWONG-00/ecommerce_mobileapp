
import '../../import.dart';

import './auth/auth.dart';

Future<void> main() async{
  // Load environment variables from a .env file

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
    scaffoldBackgroundColor: bg1,
    fontFamily: 'Inter',
    colorScheme:
      const ColorScheme.light(primary: primary1, secondary: primaryLight1),
      appBarTheme: const AppBarTheme(
          color: text2,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
              color: primary1,
              fontFamily: 'Inter',
              fontSize: 17,
              fontWeight: FontWeight.w700),
          iconTheme: IconThemeData(
            size: 18,
          ))),
      home: WidgetTree(), //this will watch the auth changes and redirect user to appropriate screen
    );
  }
}
