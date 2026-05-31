import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../screens/staff_qr_screenV2.dart';
import 'scanner_corner.dart';

class QrScannerCard extends StatelessWidget {
  final Color color;

  final ScanResultState resultState;

  final Function(BarcodeCapture capture) onDetect;

  const QrScannerCard({
    super.key,
    required this.color,
    required this.resultState,
    required this.onDetect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: 350,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(38),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: MobileScanner(
              fit: BoxFit.cover,
              onDetect: onDetect,
            ),
          ),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.black.withOpacity(.15),
            ),
          ),

          Positioned(
            top: 22,
            left: 22,
            child: ScannerCorner(
              color: color,
              topLeft: true,
            ),
          ),

          Positioned(
            top: 22,
            right: 22,
            child: ScannerCorner(
              color: color,
              topRight: true,
            ),
          ),

          Positioned(
            bottom: 22,
            left: 22,
            child: ScannerCorner(
              color: color,
              bottomLeft: true,
            ),
          ),

          Positioned(
            bottom: 22,
            right: 22,
            child: ScannerCorner(
              color: color,
              bottomRight: true,
            ),
          ),
        ],
      ),
    );
  }
}