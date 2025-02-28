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
    TextTheme textTheme = Theme.of(context).textTheme;
    return TextFormField(
      style: textTheme.titleMedium,
      cursorColor: AppTheme.primary,
      validator: widget.validator,
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: isObscure,
      maxLines: widget.maxLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: textTheme.titleSmall,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        filled: true,
        fillColor: AppTheme.gray,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        prefixIcon: widget.prefixIconPath != null
            ? Padding(
                padding: const EdgeInsets.only(left: 19, right: 10),
                child: SvgPicture.asset(
                  widget.prefixIconPath!,
                ),
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
    );
  }
}
