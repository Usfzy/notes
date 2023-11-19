import 'package:flutter/material.dart';
import 'package:skeleton_app/core/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final double elevation;
  final double borderRadius;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    this.elevation = 8.0,
    this.borderRadius = 8.0,
    this.backgroundColor = kDarkBlueColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(elevation),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // radius you want
            side: const BorderSide(
              color: Colors.transparent, //color
            ),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Text(text),
      ),
    );
  }
}
