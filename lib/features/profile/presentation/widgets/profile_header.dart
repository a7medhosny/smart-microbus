import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/profile.dart';
import 'profile_avatar.dart';

class ProfileHeader extends StatefulWidget {
  final Profile profile;

  const ProfileHeader({super.key, required this.profile});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  bool isEditing = false;
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tr = AppLocalizations.of(context)!;

    nameController.text = widget.profile.name;

    return Column(
      children: [
        /// 🔵 Top Gradient + Avatar
        SizedBox(
          height: 230,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary.withOpacity(.7),
                      theme.colorScheme.primary,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),

              /// Avatar
              Positioned(top: 110, child: ProfileAvatar()),
            ],
          ),
        ),

        // const SizedBox(height: 10),

        /// ✏️ Name + Edit
        Text(
          widget.profile.name,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
