import 'package:flutter/material.dart';

class FieldWidget extends StatelessWidget {

  final String image;
  final String name;

  const FieldWidget({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8), 
      child: Center(
        child: GestureDetector(
          child: Column(
            children: [
              Image.asset(image, width: 150, height: 150, alignment: Alignment.center,),
              const SizedBox(height: 10),
              Text(name, style: const TextStyle(fontSize: 26))
            ]
          ),
        )
      )
    );
  }
}