import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_microbus/features/staff_qr/presentation/widgets/V1_widgets/scanner_view.dart';
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
import '../widgets/V1_widgets/bus_scan_action_card.dart';
import '../widgets/V1_widgets/scanner_status_card.dart';
import '../widgets/V1_widgets/staff_qr_app_bar.dart';

class StaffQrScreen extends StatefulWidget {
  const StaffQrScreen({super.key});

  @override
  State<StaffQrScreen> createState() => _StaffQrScreenState();
}

class _StaffQrScreenState extends State<StaffQrScreen> {
  bool scanned = false;

  void _openScanner(ScanActionType type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ScannerView(
          type: type,
          onDetect: (code) {
            if (scanned) return;

            scanned = true;

            if (type.isEntry) {
              context.read<StaffQrCubit>().checkIn(code);
            } else {
              context.read<StaffQrCubit>().checkOut(code);
            }

            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tr = AppLocalizations.of(context)!;

    return BlocConsumer<StaffQrCubit, StaffQrState>(
      listener: (context, state) {
        if (state is StaffQrSuccess) {
          ShowToastHelper.showToast(context, state.message);
        }

        if (state is StaffQrError) {
          ShowToastHelper.showToast(
            context,
            state.message,
            backgroundColor: theme.colorScheme.error,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              // =========================
              // Background
              // =========================
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      theme.colorScheme.primary.withOpacity(.08),
                      theme.colorScheme.surface,
                      theme.colorScheme.surface,
                      theme.colorScheme.secondary.withOpacity(.05),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: -120,
                right: -80,
                child: Container(
                  height: 260,
                  width: 260,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.primary.withOpacity(.12),
                  ),
                ),
              ),

              Positioned(
                bottom: -120,
                left: -100,
                child: Container(
                  height: 260,
                  width: 260,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.secondary.withOpacity(.10),
                  ),
                ),
              ),

              // =========================
              // Content
              // =========================
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              children: [
                                // =========================
                                // App Bar
                                // =========================
                                StaffQrAppBar(
                                  onThemeTap: () {
                                    context.read<ThemeCubit>().toggleTheme();
                                  },
                                  onLanguageTap: () {
                                    context.read<LocaleCubit>().toggleLocale();
                                  },
                                  onLogoutTap: () {
                                    TokenManager.clearLoginData();

                                    DioFactory.removeAuthInterceptor();

                                    context.pushNamedAndRemoveUntil(
                                      Routes.login,
                                    );
                                  },
                                ),

                                const SizedBox(height: 24),

                                // =========================
                                // Status Card
                                // =========================
                                ScannerStatusCard(
                                  status: tr.systemReadyForScanning,
                                ),

                                const SizedBox(height: 24),

                                // =========================
                                // Scan Cards
                                // =========================
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: BusScanActionCard(
                                          type: ScanActionType.entry,
                                          onTap: () {
                                            scanned = false;

                                            _openScanner(ScanActionType.entry);
                                          },
                                        ),
                                      ),

                                      const SizedBox(height: 18),

                                      Expanded(
                                        child: BusScanActionCard(
                                          type: ScanActionType.exit,
                                          onTap: () {
                                            scanned = false;

                                            _openScanner(ScanActionType.exit);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // =========================
                                // Loading
                                // =========================
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 250),
                                  child: state is StaffQrLoading
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                            top: 20,
                                            bottom: 12,
                                          ),
                                          child: SizedBox(
                                            height: 26,
                                            width: 26,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 3,
                                              color: theme.colorScheme.primary,
                                            ),
                                          ),
                                        )
                                      : const SizedBox(height: 12),
                                ),

                                // =========================
                                // Hint
                                // =========================
                                const ScannerHint(),

                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

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
