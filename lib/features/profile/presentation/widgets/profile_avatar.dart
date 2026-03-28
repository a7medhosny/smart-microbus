import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../core/helpers/image_helper.dart';
import '../../../../core/helpers/show_toast_helper.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

String getFullImageUrl(String path) {
  if (path.startsWith('http')) return path;

  if (path.startsWith('/')) {
    return "https://smart-microbus.runasp.net$path";
  } else {
    return "https://smart-microbus.runasp.net/$path";
  }
}

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({super.key});

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  static const double _size = 100;

  File? _localImage;

  Future<void> _changePhoto() async {
    final image = await ImageHelper.pickCropImage();
    if (image == null) return;

    setState(() => _localImage = image);
    context.read<ProfileCubit>().uploadProfilePhoto(image);
  }

  void _deletePhoto() {
    context.read<ProfileCubit>().deleteProfilePhoto();
    setState(() => _localImage = null);
  }

  void _showOptions(AppLocalizations tr) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo),
                title: Text(tr.changePhoto),
                onTap: () {
                  Navigator.pop(context);
                  _changePhoto();
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: Text(tr.deletePhoto),
                onTap: () {
                  Navigator.pop(context);
                  _deletePhoto();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _actionIcon({required IconData icon, required VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }

  Widget _defaultAvatar() {
    final theme = Theme.of(context);
    return Container(
      alignment: Alignment.center,
      color: theme.colorScheme.inverseSurface.withOpacity(0.3),
      child: Icon(
        Icons.person_rounded,
        size: 50,
        color: theme.colorScheme.onPrimary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();
        final profile = cubit.currentUserProfile;

        final isLoading =
            state is ProfilePhotoUploading || state is ProfilePhotoDeletLoading;

        ImageProvider? imageProvider;

        if (_localImage != null) {
          imageProvider = FileImage(_localImage!);
        } else if (profile?.photoUrl != null && profile!.photoUrl!.isNotEmpty) {
          imageProvider = CachedNetworkImageProvider(
            getFullImageUrl(profile.photoUrl!),
          );
        }

        final hasImage = imageProvider != null;

        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: _size,
              height: _size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: ClipOval(
                child: GestureDetector(
                  onTap: () {},
                  child: imageProvider != null
                      ? Image(image: imageProvider, fit: BoxFit.cover)
                      : _defaultAvatar(),
                ),
              ),
            ),

            /// 👇 الأيقونة (كاميرا أو Edit)
            Positioned(
              bottom: 4,
              right: 2,
              child: _actionIcon(
                icon: hasImage ? Icons.edit_rounded : Icons.camera_alt_rounded,
                onTap: isLoading
                    ? null
                    : () {
                        if (hasImage) {
                          _showOptions(AppLocalizations.of(context)!);
                        } else {
                          _changePhoto();
                        }
                      },
              ),
            ),

            if (isLoading)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
          ],
        );
      },
    );
  }
}
