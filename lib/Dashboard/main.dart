import 'package:flutter/material.dart';
import 'package:to_do_app_new/constants/main.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:attendance_app/camera_page/main.dart';

class FacultyDashboard extends StatefulWidget {
  final token;
  const FacultyDashboard({@required this.token, Key? key}) : super(key: key);

  @override
  State<FacultyDashboard> createState() => _FacultyDashboardState();
}

class _FacultyDashboardState extends State<FacultyDashboard> {
  late String email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: kBgColor,
      ),
      body: Column(children: [
        Text(email),
        ElevatedButton(
          onPressed: () {},
          child: const Text("Go to click pic"),
        )
      ]),
    );
  }
}
