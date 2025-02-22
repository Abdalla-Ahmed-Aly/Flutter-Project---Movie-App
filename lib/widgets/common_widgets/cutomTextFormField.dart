import 'package:movieapp/theme/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextFormFieldCustom extends StatefulWidget {
  const TextFormFieldCustom({
    super.key,
    this.controller,
    required this.hintText,
    this.prefixIconPath,
    this.validator,
    this.isPassword = false,
    this.onChanged,
    this.maxLines = 1,
  });

  final TextEditingController? controller;
  final String hintText;
  final String? prefixIconPath;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool isPassword;
  final int maxLines;

  @override
  State<TextFormFieldCustom> createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {
  late bool isObscure = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: isObscure,
      maxLines: widget.maxLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        filled: true,
        fillColor: AppTheme.gray,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        hintStyle: TextStyle(color: AppTheme.white),

        prefixIcon: widget.prefixIconPath != null
            ? Padding(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(widget.prefixIconPath!,),
        )
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
          onPressed: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
          icon: Icon(
            isObscure
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: AppTheme.white,
          ),
        )
            : null,
        suffixIconColor: AppTheme.white,
      ),
      style: TextStyle(
        color: AppTheme.white,
      ),
    );
  }
}