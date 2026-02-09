import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.validator,
    required this.hintText,
    this.keyboardType = TextInputType.text,
  });

  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final TextInputType keyboardType;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final isPasswordField = widget.labelText.toLowerCase().contains('password');

    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: isPasswordField ? _obscureText : false,
      keyboardType: widget.keyboardType,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        border: const UnderlineInputBorder(),
        suffixIcon:
            isPasswordField
                ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
                : null,
      ),
    );
  }
}
