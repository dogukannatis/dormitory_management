import 'package:flutter/material.dart';

class ButtonLoading extends StatelessWidget {
  final String buttonText;
  const ButtonLoading({
    super.key,
    required this.buttonText
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(buttonText),
        SizedBox(width: 5,),
        SizedBox(
            height: 16,
            width: 16,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white,))
      ],
    );
  }
}