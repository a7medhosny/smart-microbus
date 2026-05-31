import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:smart_microbus/l10n/app_localizations.dart';

import '../cubit/staff_qr_cubit.dart';
import '../cubit/staff_qr_state.dart';



import '../widgets/V2_widgets/qr_scanner_card.dart';
import '../widgets/V2_widgets/scan_result_overlay.dart';
import '../widgets/V2_widgets/scanner_status_card.dart';
import '../widgets/V2_widgets/scanner_type_switch.dart';
import '../widgets/V2_widgets/staff_qr_header.dart';


class StaffQrScreen extends StatefulWidget {
  const StaffQrScreen({super.key});

  @override
  State<StaffQrScreen> createState() => _StaffQrScreenState();
}

class _StaffQrScreenState extends State<StaffQrScreen>
    with SingleTickerProviderStateMixin {
  bool scanned = false;

  ScanActionType selectedType = ScanActionType.entry;

  ScanResultState resultState = ScanResultState.idle;

  String statusMessage = "";

  late final AnimationController pulseController;

  @override
  void initState() {
    super.initState();

    pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    pulseController.dispose();

    super.dispose();
  }

  Future<void> showResult({
    required ScanResultState state,
    required String message,
  }) async {
    setState(() {
      resultState = state;

      statusMessage = message;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        resultState = ScanResultState.idle;

        scanned = false;
      });
    }
  }

  void onDetectQr(BarcodeCapture capture) {
    final code = capture.barcodes.first.rawValue;

    if (code == null ||
        scanned ||
        resultState == ScanResultState.loading) {
      return;
    }

    scanned = true;

    HapticFeedback.mediumImpact();

    if (selectedType.isEntry) {
      context.read<StaffQrCubit>().checkIn(code);
    } else {
      context.read<StaffQrCubit>().checkOut(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final tr = AppLocalizations.of(context)!;

    final selectedColor = selectedType.color(context);

    return BlocConsumer<StaffQrCubit, StaffQrState>(
      listener: (context, state) async {
        if (state is StaffQrLoading) {
          setState(() {
            resultState = ScanResultState.loading;

            statusMessage = tr.loading;
          });
        }

        if (state is StaffQrSuccess) {
          HapticFeedback.heavyImpact();

          await showResult(
            state: ScanResultState.success,
            message: state.message,
          );
        }

        if (state is StaffQrError) {
          HapticFeedback.vibrate();

          await showResult(
            state: ScanResultState.error,
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.colorScheme.surface,
          body: Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 18,
                  ),
                  child: Column(
                    children: [
                      // =========================
                      // HEADER
                      // =========================

                      StaffQrHeader(
                        color: selectedColor,
                        pulseController: pulseController,
                        title: tr.busGateScanner,
                        subtitle: tr.readyForScanning,
                      ),

                      const SizedBox(height: 26),

                      // =========================
                      // TYPE SWITCH
                      // =========================

                      ScannerTypeSwitch(
                        selectedType: selectedType,

                        entryTitle: tr.busEntry,
                        entrySubtitle: tr.allowBusEntry,

                        exitTitle: tr.busExit,
                        exitSubtitle: tr.registerBusExit,

                        onEntryTap: () {
                          setState(() {
                            selectedType =
                                ScanActionType.entry;
                          });
                        },

                        onExitTap: () {
                          setState(() {
                            selectedType =
                                ScanActionType.exit;
                          });
                        },
                      ),

                      const Spacer(),

                      // =========================
                      // QR SCANNER
                      // =========================

                      QrScannerCard(
                        color: selectedColor,
                        resultState: resultState,
                        onDetect: onDetectQr,
                      ),

                      const SizedBox(height: 28),

                      // =========================
                      // STATUS CARD
                      // =========================

                      ScannerStatusCard(
                        resultState: resultState,
                        loadingText: tr.loading,
                        readyText: tr.readyForScanning,
                      ),

                      const Spacer(),
                    ],
                  ),
                ),
              ),

              // =========================
              // RESULT OVERLAY
              // =========================

              AnimatedSwitcher(
                duration:
                    const Duration(milliseconds: 350),
                child: ScanResultOverlay(
                  resultState: resultState,
                  message: statusMessage,
                  loadingText: tr.loading,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

enum ScanResultState {
  idle,
  loading,
  success,
  error,
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

    return isEntry
        ? theme.colorScheme.primary
        : theme.colorScheme.error;
  }
}