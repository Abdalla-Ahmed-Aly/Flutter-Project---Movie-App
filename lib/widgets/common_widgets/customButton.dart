import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonTitle;
  final Color buttonColor;
  final Color fontColor;
  final bool notFillColor;

  const CustomButton({
    super.key,
    required this.buttonTitle,
    required this.buttonColor,
    required this.fontColor,
    this.notFillColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              WidgetStatePropertyAll(notFillColor ? Colors.black : buttonColor),
          fixedSize: WidgetStatePropertyAll(
            Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.06,
            ),
          ),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                side: BorderSide(color: Colors.amber)),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          buttonTitle,
          style: TextStyle(
              color: notFillColor ? Colors.amber : fontColor, fontSize: 20),
        ),
      ),
    );
  }
}
