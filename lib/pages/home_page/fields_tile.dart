import 'package:flutter/material.dart';

class FieldWidget extends StatelessWidget {
  final String image;
  final String name;
  final Function onTap;
  final bool isDisabled;

  const FieldWidget({super.key, required this.image, required this.name,required this.onTap, this.isDisabled = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
            child: GestureDetector(
          onTap: isDisabled ? null : () {
            onTap();
          },
          child: Column(children: [
            Container(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 16,
                      offset: Offset(0, 6))
                ]),
                child: Image.asset(
                  image,
                  width: 150,
                  height: 150,
                  alignment: Alignment.center,
                  opacity: isDisabled ? const AlwaysStoppedAnimation(0.3) : const AlwaysStoppedAnimation(1),
                )),
            const SizedBox(height: 10),
            Text(name, style: const TextStyle(fontSize: 26))
          ]),
        ),
        ));
  }
}
