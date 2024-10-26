import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final void Function()? onTap;
  const MyButton({super.key,required this.label,required this.onTap});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: 61,
        decoration: BoxDecoration(
            color: Colors.tealAccent,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: width * 0.049),
        ),
      ),
    );
  }
}
