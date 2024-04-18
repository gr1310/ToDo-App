import 'package:flutter/material.dart';
import 'constants/main.dart';

class StyledTextField extends StatelessWidget {
  // const StyledTextField({
  //   super.key,
  // });
  const StyledTextField({super.key, this.text, this.ctrlr, this.ans});
  final String? text;
  final TextEditingController? ctrlr;
  final bool? ans;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      child: TextField(
        controller: ctrlr,
        decoration: InputDecoration(

          errorText: ans!? "Enter proper info":null,
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.circular(30),
            ),
            hintStyle: const TextStyle(color: kDimTextColor),
            hintText: text,
            contentPadding: const EdgeInsets.all(16),
            filled: true,
            fillColor: const Color(0xFFEBE8E5)),
      ),
    );
  }
}