import 'package:flutter/material.dart';

class MenuSwitchTile extends StatelessWidget {
  const MenuSwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.icon,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(icon, size: 22, color: theme.colorScheme.primary),

      title: Text(
        title,
        style: TextStyle(
          color: theme.textTheme.bodyLarge!.color,
          fontWeight: FontWeight.w500,
        ),
      ),

      trailing: Transform.scale(
        scale: 0.75,
        child: Switch(value: value, onChanged: onChanged),
      ),
    );
  }
}
