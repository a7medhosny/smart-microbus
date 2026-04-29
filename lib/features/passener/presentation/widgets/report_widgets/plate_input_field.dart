import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../l10n/app_localizations.dart';

class PlateInputField extends StatelessWidget {
  final TextEditingController letter1Controller;
  final TextEditingController letter2Controller;
  final TextEditingController numbersController;
  final String? label;
  final void Function(String plate)? onChanged;

  const PlateInputField({
    super.key,
    required this.letter1Controller,
    required this.letter2Controller,
    required this.numbersController,
    this.label,
    this.onChanged,
  });

  String getPlate() {
    return "${letter1Controller.text} ${letter2Controller.text} ${numbersController.text}"
        .trim()
        .replaceAll(RegExp(r'\s+'), ' ');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tr = AppLocalizations.of(context)!;

    final focus1 = FocusNode();
    final focus2 = FocusNode();
    final focus3 = FocusNode();

    OutlineInputBorder border(Color color, {double width = 1.5}) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    InputDecoration buildDecoration(String hint) {
      return InputDecoration(
        hintText: hint,
        hintStyle: theme.textTheme.titleMedium?.copyWith(
          color: theme.hintColor,
          fontWeight: FontWeight.w200,
        ),
        labelStyle: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
        counterText: "",
        border: border(theme.dividerColor),
        enabledBorder: border(theme.dividerColor),
        focusedBorder: border(theme.colorScheme.primary, width: 2),
        filled: true,
        fillColor: theme.colorScheme.surface,
      );
    }

    void triggerOnChange() {
      if (onChanged != null) {
        onChanged!(getPlate());
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if (label != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            label ?? tr.plate_number,
            style: theme.textTheme.titleMedium,
          ),
        ),

        Row(
          children: [
            /// ===== حرف 1 =====
            Expanded(
              child: TextField(
                focusNode: focus1,
                controller: letter1Controller,
                maxLength: 1,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\u0600-\u06FF]')),
                ],
                decoration: buildDecoration('أ'),
                onChanged: (value) {
                  if (value.length == 1) {
                    FocusScope.of(context).requestFocus(focus2);
                  }
                  triggerOnChange();
                },
              ),
            ),

            const SizedBox(width: 8),

            /// ===== حرف 2 =====
            Expanded(
              child: TextField(
                focusNode: focus2,
                controller: letter2Controller,
                maxLength: 1,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\u0600-\u06FF]')),
                ],
                decoration: buildDecoration('ب'),
                onChanged: (value) {
                  if (value.length == 1) {
                    FocusScope.of(context).requestFocus(focus3);
                  } else if (value.isEmpty) {
                    FocusScope.of(context).requestFocus(focus1);
                  }
                  triggerOnChange();
                },
              ),
            ),

            const SizedBox(width: 8),

            /// ===== أرقام =====
            Expanded(
              flex: 2,
              child: TextField(
                focusNode: focus3,
                controller: numbersController,
                maxLength: 4,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: buildDecoration('1234'),
                onChanged: (value) {
                  if (value.isEmpty) {
                    FocusScope.of(context).requestFocus(focus2);
                  }
                  triggerOnChange();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
