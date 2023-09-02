import 'package:flutter/material.dart';

class DecoButton extends StatelessWidget {
  const DecoButton({super.key, this.label, this.child, required this.onClick});

  final String? label;
  final Widget? child;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(30),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xfff71a5d), width: 1),
            ),
          ),
          Positioned(
            top: -8,
            left: -8,
            bottom: 8,
            right: 8,
            child: Container(
              margin: const EdgeInsets.all(30),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [Color.fromRGBO(251, 90, 70, 1), Color(0xfff71a5d)],
                ),
              ),
              child: Center(
                child: (label != null)
                    ? Text(
                        label!,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    : child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
