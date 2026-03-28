import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  const MenuTile(
    this.icon,
    this.onTap,
    this.title, {
    super.key,
    this.isDanger = false,
  });

  final IconData icon;
  final Function()? onTap;
  final String title;
  final bool isDanger;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDanger ? Colors.red : Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDanger
              ? Colors.red
              : Theme.of(context).textTheme.bodyLarge!.color,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
