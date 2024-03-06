import 'package:flutter/material.dart';

class PlusFloatingButton extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final  function;
  const PlusFloatingButton({super.key, required this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.deepPurple[300],
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.shade500,
              offset: const Offset(4.0, 4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Colors.deepPurple.shade300,
              offset: const Offset(-4.0, -4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Text(
              "+",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
