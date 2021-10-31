import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final String text;
  final Function? onPressed;
  const FormButton({required this.text, this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return ElevatedButton(
      onPressed: onPressed as void Function()?,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 16,
            color: onPressed == null ? Colors.grey : Colors.blue,
            fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.025, horizontal: screenWidth * 0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
