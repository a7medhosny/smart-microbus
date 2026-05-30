import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../screens/staff_qr_screen.dart';

class ScannerView extends StatefulWidget {
  final ScanActionType type;
  final Function(String code) onDetect;

  const ScannerView({super.key, required this.type, required this.onDetect});

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    final color = widget.type.color(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (capture) {
              final code = capture.barcodes.first.rawValue;

              if (code == null) return;

              HapticFeedback.mediumImpact();

              widget.onDetect(code);
            },
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.3),
                  Colors.black.withOpacity(.8),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          Center(
            child: SizedBox(
              width: 280,
              height: 280,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: color.withOpacity(.5),
                        width: 2,
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: color, width: 5),
                          left: BorderSide(color: color, width: 5),
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: color, width: 5),
                          right: BorderSide(color: color, width: 5),
                        ),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(24),
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: color, width: 5),
                          left: BorderSide(color: color, width: 5),
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: color, width: 5),
                          right: BorderSide(color: color, width: 5),
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(24),
                        ),
                      ),
                    ),
                  ),

                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return Positioned(
                        top: _controller.value * 240,
                        left: 20,
                        right: 20,
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                color,
                                Colors.transparent,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: color.withOpacity(.8),
                                blurRadius: 18,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.1),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const Spacer(),

                      Text(
                        widget.type.title(tr),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),

                      const Spacer(),

                      const SizedBox(width: 52),
                    ],
                  ),

                  const Spacer(),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.08),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tr.placeQrInsideFrame,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),

                  const SizedBox(height: 70),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}