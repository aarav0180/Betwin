import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
        onPressed: (){},
        child: Text(text),
        style: ElevatedButton.styleFrom(
            minimumSize: Size(width/2.3, 50)


        )
    );
  }
}

