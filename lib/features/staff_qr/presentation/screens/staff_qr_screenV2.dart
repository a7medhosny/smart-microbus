import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../../../../core/auth/token_manager.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/show_toast_helper.dart';
import '../../../../core/localization/locale_cubit.dart';
import '../../../../core/networking/dio_factory.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../cubit/staff_qr_cubit.dart';
import '../cubit/staff_qr_state.dart';

// =======================================================
// MODEL
// =======================================================

enum ScanActionType { entry, exit }

extension ScanActionTypeX on ScanActionType {
  bool get isEntry => this == ScanActionType.entry;

  IconData get icon {
    return isEntry ? Icons.login_rounded : Icons.logout_rounded;
  }

  String title(AppLocalizations tr) {
    return isEntry ? tr.busEntry : tr.busExit;
  }

  String subtitle(AppLocalizations tr) {
    return isEntry ? tr.allowBusEntry : tr.registerBusExit;
  }

  Color color(BuildContext context) {
    final theme = Theme.of(context);

    return isEntry ? theme.colorScheme.primary : theme.colorScheme.error;
  }
}

// =======================================================
// MAIN SCREEN
// =======================================================

class StaffQrScreen extends StatefulWidget {
  const StaffQrScreen({super.key});

  @override
  State<StaffQrScreen> createState() => _StaffQrScreenState();
}

class _StaffQrScreenState extends State<StaffQrScreen> {
  bool scanned = false;

  ScanActionType selectedType = ScanActionType.entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final tr = AppLocalizations.of(context)!;

    final selectedColor = selectedType.color(context);

    return BlocConsumer<StaffQrCubit, StaffQrState>(
      listener: (context, state) {
        if (state is StaffQrSuccess) {
          scanned = false;

          ShowToastHelper.showToast(context, state.message);
        }

        if (state is StaffQrError) {
          scanned = false;

          ShowToastHelper.showToast(
            context,
            state.message,
            backgroundColor: theme.colorScheme.error,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.colorScheme.surface,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
              child: Column(
                children: [
                  // =========================
                  // Header
                  // =========================
                  Row(
                    children: [
                      Container(
                        height: 54,
                        width: 54,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: LinearGradient(
                            colors: [
                              selectedColor,
                              selectedColor.withOpacity(.7),
                            ],
                          ),
                        ),
                        child: const Icon(
                          Icons.qr_code_scanner_rounded,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr.busGateScanner,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w900,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              tr.readyForScanning,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),

                      PopupMenuButton<String>(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onSelected: (value) {
                          switch (value) {
                            case "theme":
                              context.read<ThemeCubit>().toggleTheme();
                              break;

                            case "language":
                              context.read<LocaleCubit>().toggleLocale();
                              break;

                            case "logout":
                              TokenManager.clearLoginData();

                              DioFactory.removeAuthInterceptor();

                              context.pushNamedAndRemoveUntil(Routes.login);
                              break;
                          }
                        },
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              value: "theme",
                              child: Text(tr.changeTheme),
                            ),

                            PopupMenuItem(
                              value: "language",
                              child: Text(tr.changeLanguage),
                            ),

                            const PopupMenuDivider(),

                            PopupMenuItem(
                              value: "logout",
                              child: Text(tr.logout),
                            ),
                          ];
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // =========================
                  // Scanner Type Buttons
                  // =========================
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _ScannerTypeButton(
                            active: selectedType == ScanActionType.entry,
                            color: theme.colorScheme.primary,
                            icon: Icons.login_rounded,
                            title: tr.busEntry,
                            subtitle: tr.allowBusEntry,
                            onTap: () {
                              setState(() {
                                scanned = false;

                                selectedType = ScanActionType.entry;
                              });
                            },
                          ),
                        ),

                        const SizedBox(width: 8),

                        Expanded(
                          child: _ScannerTypeButton(
                            active: selectedType == ScanActionType.exit,
                            color: theme.colorScheme.error,
                            icon: Icons.logout_rounded,
                            title: tr.busExit,
                            subtitle: tr.registerBusExit,
                            onTap: () {
                              setState(() {
                                scanned = false;

                                selectedType = ScanActionType.exit;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // =========================
                  // Live Scanner
                  // =========================
                  Container(
                    height: 320,
                    width: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(42),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          selectedColor.withOpacity(.08),
                          selectedColor.withOpacity(.03),
                        ],
                      ),
                      border: Border.all(
                        color: selectedColor.withOpacity(.25),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: selectedColor.withOpacity(.12),
                          blurRadius: 40,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // =====================
                        // Camera
                        // =====================
                        ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: SizedBox(
                            height: 210,
                            width: 210,
                            child: MobileScanner(
                              fit: BoxFit.cover,
                              onDetect: (capture) {
                                final code = capture.barcodes.first.rawValue;

                                if (code == null || scanned) {
                                  return;
                                }

                                scanned = true;

                                HapticFeedback.mediumImpact();

                                if (selectedType.isEntry) {
                                  context.read<StaffQrCubit>().checkIn(code);
                                } else {
                                  context.read<StaffQrCubit>().checkOut(code);
                                }
                              },
                            ),
                          ),
                        ),

                        // =====================
                        // Corners
                        // =====================
                        Positioned(
                          top: 38,
                          left: 38,
                          child: _ScannerCorner(
                            color: selectedColor,
                            topLeft: true,
                          ),
                        ),

                        Positioned(
                          top: 38,
                          right: 38,
                          child: _ScannerCorner(
                            color: selectedColor,
                            topRight: true,
                          ),
                        ),

                        Positioned(
                          bottom: 38,
                          left: 38,
                          child: _ScannerCorner(
                            color: selectedColor,
                            bottomLeft: true,
                          ),
                        ),

                        Positioned(
                          bottom: 38,
                          right: 38,
                          child: _ScannerCorner(
                            color: selectedColor,
                            bottomRight: true,
                          ),
                        ),

                        // =====================
                        // Scan Line
                        // =====================
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: -70, end: 70),
                          duration: const Duration(milliseconds: 1600),
                          curve: Curves.easeInOut,
                          builder: (_, value, child) {
                            return Transform.translate(
                              offset: Offset(0, value),
                              child: child,
                            );
                          },
                          child: Container(
                            width: 180,
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  selectedColor,
                                  Colors.transparent,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: selectedColor.withOpacity(.6),
                                  blurRadius: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    tr.placeQrInsideFrame,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    tr.scanInstruction,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // =========================
                  // Loading / Status
                  // =========================
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: state is StaffQrLoading
                        ? SizedBox(
                            height: 26,
                            width: 26,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: selectedColor,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.green.withOpacity(.4),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 10),

                              Text(
                                tr.readyForScanning,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// =======================================================
// TYPE BUTTON
// =======================================================

class _ScannerTypeButton extends StatelessWidget {
  final bool active;
  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ScannerTypeButton({
    required this.active,
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: active ? color.withOpacity(.12) : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: active ? color : theme.colorScheme.onSurfaceVariant,
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: active ? color : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =======================================================
// SCANNER CORNER
// =======================================================

class _ScannerCorner extends StatelessWidget {
  final Color color;

  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;

  const _ScannerCorner({
    required this.color,
    this.topLeft = false,
    this.topRight = false,
    this.bottomLeft = false,
    this.bottomRight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: topLeft ? const Radius.circular(18) : Radius.zero,
          topRight: topRight ? const Radius.circular(18) : Radius.zero,
          bottomLeft: bottomLeft ? const Radius.circular(18) : Radius.zero,
          bottomRight: bottomRight ? const Radius.circular(18) : Radius.zero,
        ),
        border: Border(
          top: topLeft || topRight
              ? BorderSide(color: color, width: 4)
              : BorderSide.none,
          left: topLeft || bottomLeft
              ? BorderSide(color: color, width: 4)
              : BorderSide.none,
          right: topRight || bottomRight
              ? BorderSide(color: color, width: 4)
              : BorderSide.none,
          bottom: bottomLeft || bottomRight
              ? BorderSide(color: color, width: 4)
              : BorderSide.none,
        ),
      ),
    );
  }
}
