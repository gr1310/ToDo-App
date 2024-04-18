import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app_new/Dashboard/main.dart';
import 'constants/main.dart';
import 'login_page/main.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs= await SharedPreferences.getInstance();

  String text = prefs.getString('token')?? "got null value";
  print('Token from SharedPreferences: $text');
  // runApp(ToDoApp(token: prefs.getString('token'),));
  runApp(ToDoApp(token: text,));
}

class ToDoApp extends StatelessWidget {
  final token;

  const ToDoApp({@required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      // Attempt to decode the token
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

      // Check if the token is expired
      bool isTokenExpired = JwtDecoder.isExpired(token);

      // Determine whether to show the dashboard or login page based on token expiration
      return MaterialApp(
          theme: ThemeData.light().copyWith(primaryColor: kLightBluishBg,
          scaffoldBackgroundColor: kLightBluishBg),
        home: isTokenExpired ? LoginPage() : FacultyDashboard(token: token),
      );
    } catch (e) {
      // Handle the FormatException (invalid token)
      print('Error decoding or handling token: $e');

      // Handle the error, e.g., show an error message or redirect to login
      return MaterialApp(
        home: LoginPage(),
      );
    }
  }
}
