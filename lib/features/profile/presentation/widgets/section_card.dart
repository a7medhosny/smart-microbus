import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Theme.of(context).colorScheme.primary.withAlpha(20),
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: children
              .map(
                (e) => Column(
                  children: [
                    e,
                    verticalSpace(5),
                    if (e != children.last)
                      Divider(color: Theme.of(context).dividerColor, height: 1),
                    verticalSpace(5),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
