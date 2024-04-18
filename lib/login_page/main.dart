import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app_new/constants/main.dart';
import 'package:to_do_app_new/registration_page/main.dart';
import 'package:to_do_app_new/Dashboard/main.dart';
import 'package:http/http.dart' as http;
import 'package:to_do_app_new/config.dart';
// import 'package:attendance_app/registration_page/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  bool _isValid = false;

  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));
  }

  void loginUser() async {
    if (emailCtrl.text.isNotEmpty && passCtrl.text.isNotEmpty) {
      // setState(() {
      //   _isValid=false;
      // });
      var regBody = {"email": emailCtrl.text, "password": passCtrl.text};
      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));
      print(response);
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (jsonResponse['status'] == true) {
        print("Success");
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);
        print(myToken);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FacultyDashboard(token: myToken)));
      } else {
        print("Failed");
      }
    } else {
      setState(() {
        _isValid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(flex: 2, child: SizedBox()),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Container(
                height: 500,
                decoration: const BoxDecoration(
                  color: kBgColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'Welcome Back!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 33),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Sign in to your account',
                        style: TextStyle(
                            color: kDimTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: TextField(
                        controller: emailCtrl,
                        decoration: InputDecoration(
                            errorText: _isValid? "Enter proper info":null,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            hintStyle: const TextStyle(color: kDimTextColor),
                            hintText: 'Username',
                            contentPadding: const EdgeInsets.all(16),
                            filled: true,
                            fillColor: const Color(0xFFEBE8E5)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: TextField(
                        controller: passCtrl,
                        obscureText: passwordVisible,
                        decoration: InputDecoration(
                            errorText: _isValid? "Enter proper info":null,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            hintStyle: const TextStyle(color: kDimTextColor),
                            hintText: 'Password',
                            helperText:
                                "Password must contain special character",
                            helperStyle: const TextStyle(color: kDimTextColor),
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                            contentPadding: const EdgeInsets.all(16),
                            filled: true,
                            fillColor: const Color(0xFFEBE8E5)),
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    // TextButton(
                    //     onPressed: () {},
                    //     child: const Text(
                    //       "Forgot Password?",
                    //       style: TextStyle(color: kDimTextColor),
                    //     )),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            loginUser();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kLightBluishBg),
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const Registration();
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(color: kLightBluishBg),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
