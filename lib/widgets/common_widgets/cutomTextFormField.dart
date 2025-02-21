import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextFormFieldCustom extends StatefulWidget {
  final String hintText;
  final String? iconSVGpath;
  final IconButton? sufIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isObscured;

  const TextFormFieldCustom({
    super.key,
    required this.hintText,
    this.controller,
    this.iconSVGpath,
    this.sufIcon,
    this.validator,
    this.isObscured = false,
  });

  @override
  State<TextFormFieldCustom> createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        obscureText: widget.isObscured,
        controller: widget.controller,
        validator: widget.validator,
        decoration: InputDecoration(
            hintText: widget.hintText,
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
            filled: true,
            fillColor: const Color(0xFF282A28),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            hintStyle: const TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.amber),
            ),
            prefixIcon: widget.iconSVGpath != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(widget.iconSVGpath!),
                  )
                : null,
            suffixIcon: widget.sufIcon,
            suffixIconColor: Colors.white),
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
