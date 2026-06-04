import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../l10n/app_localizations.dart';
import 'plate_letter_field.dart';

class PlateInputField extends StatelessWidget {
  final TextEditingController letter1Controller;
  final TextEditingController letter2Controller;
  final TextEditingController letter3Controller;
  final TextEditingController numbersController;
  final String? label;
  final void Function(String plate)? onChanged;

  const PlateInputField({
    super.key,
    required this.letter1Controller,
    required this.letter2Controller,
    required this.letter3Controller,
    required this.numbersController,
    this.label,
    this.onChanged,
  });



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tr = AppLocalizations.of(context)!;

    final focus1 = FocusNode();
    final focus2 = FocusNode();
    final focus3 = FocusNode();
    final focus4 = FocusNode();

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
        onChanged!(getPlate(
          letter1Controller: letter1Controller,
          letter2Controller: letter2Controller,
          letter3Controller: letter3Controller,
          numbersController: numbersController,
        ));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            PlateLetterField(
              controller: letter1Controller,
              focusNode: focus1,
              nextFocus: focus2,
              hint: 'أ',
              onChanged: triggerOnChange,
            ),

            const SizedBox(width: 8),

            PlateLetterField(
              controller: letter2Controller,
              focusNode: focus2,
              previousFocus: focus1,
              nextFocus: focus3,
              hint: 'ب',
              onChanged: triggerOnChange,
            ),

            const SizedBox(width: 8),

            PlateLetterField(
              controller: letter3Controller,
              focusNode: focus3,
              previousFocus: focus2,
              nextFocus: focus4,
              hint: 'ج',
              onChanged: triggerOnChange,
            ),

            const SizedBox(width: 8),

            /// ===== أرقام =====
            Expanded(
              flex: 2,
              child: TextField(
                focusNode: focus4,
                controller: numbersController,
                maxLength: 4,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: buildDecoration('1234'),
                onChanged: (value) {
                  if (value.isEmpty) {
                    FocusScope.of(context).requestFocus(focus3);
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

  String getPlate({
    required TextEditingController letter1Controller,
    required TextEditingController letter2Controller,
    required TextEditingController letter3Controller,
    required TextEditingController numbersController,
  }) {
    return [
      letter1Controller.text.trim(),
      letter2Controller.text.trim(),
      letter3Controller.text.trim(),
      numbersController.text.trim(),
    ].where((e) => e.isNotEmpty).join(' ');
  }
