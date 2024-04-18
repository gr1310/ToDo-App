import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:to_do_app_new/config.dart';
import 'package:to_do_app_new/constants/main.dart';
import 'package:to_do_app_new/styled_text_field.dart';
import 'package:http/http.dart' as http;
// import 'package:multi_dropdown/multiselect_dropdown.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController emailCtrl= TextEditingController();
  TextEditingController passCtrl= TextEditingController();
  bool _isValid= false;

   void registerUser() async{
     if(emailCtrl.text.isNotEmpty && passCtrl.text.isNotEmpty){
       // setState(() {
       //   _isValid=false;
       // });
       var regBody={
         "email":emailCtrl.text,
         "password": passCtrl.text
       };

       var response= await http.post(Uri.parse(register),
       headers: {"Content-Type": "application/json"},
       body: jsonEncode(regBody)
       );
      var jsonResponse= jsonDecode(response.body);
      if(jsonResponse['status']==true){
        print("Success");
      }else{
        print("Failed");
      }
     }else{
       setState(() {
         _isValid=true;
       });
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        title: const Text(
          "Register",
          style: TextStyle(
            fontSize: 40,
          ),
        ),
        backgroundColor: kBgColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StyledTextField(text: 'Email', ctrlr: emailCtrl, ans: _isValid,),
            StyledTextField(text: 'Password', ctrlr: passCtrl, ans: _isValid,),
            const SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    registerUser();
                    print(_isValid);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kLightBluishBg),
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

