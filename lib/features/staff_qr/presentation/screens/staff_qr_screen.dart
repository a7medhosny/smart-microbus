// // // =======================================================
// // // FILE: staff_qr_screen.dart
// // // =======================================================

// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smart_microbus/l10n/app_localizations.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

// import '../../../../core/auth/token_manager.dart';
// import '../../../../core/helpers/extensions.dart';
// import '../../../../core/helpers/show_toast_helper.dart';
// import '../../../../core/localization/locale_cubit.dart';
// import '../../../../core/networking/dio_factory.dart';
// import '../../../../core/routing/routes.dart';
// import '../../../../core/theme/theme_cubit.dart';
// import '../cubit/staff_qr_cubit.dart';
// import '../cubit/staff_qr_state.dart';


// // =======================================================
// // MODEL
// // FILE: models/scan_action_type.dart
// // =======================================================

// enum ScanActionType { entry, exit }

// extension ScanActionTypeX on ScanActionType {
//   bool get isEntry => this == ScanActionType.entry;

//   IconData get icon {
//     return isEntry ? Icons.login_rounded : Icons.logout_rounded;
//   }

//   String title(AppLocalizations tr) {
//     return isEntry ? tr.busEntry : tr.busExit;
//   }

//   String subtitle(AppLocalizations tr) {
//     return isEntry ? tr.allowBusEntry : tr.registerBusExit;
//   }

//   Color color(BuildContext context) {
//     final theme = Theme.of(context);

//     return isEntry ? theme.colorScheme.primary : theme.colorScheme.error;
//   }
// }

// // =======================================================
// // HELPER
// // FILE: helpers/staff_qr_snackbar.dart
// // =======================================================

// void showStaffQrSnackBar({
//   required BuildContext context,
//   required String message,
//   required bool success,
// }) {
//   final theme = Theme.of(context);

//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       behavior: SnackBarBehavior.floating,
//       backgroundColor: success
//           ? theme.colorScheme.primary
//           : theme.colorScheme.error,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       content: Text(
//         message,
//         style: const TextStyle(fontWeight: FontWeight.w600),
//       ),
//     ),
//   );
// }

// // =======================================================
// // WIDGET
// // FILE: widgets/staff_qr_app_bar.dart
// // =======================================================

// class StaffQrAppBar extends StatelessWidget {
//   final VoidCallback onThemeTap;
//   final VoidCallback onLanguageTap;
//   final VoidCallback onLogoutTap;

//   const StaffQrAppBar({
//     super.key,
//     required this.onThemeTap,
//     required this.onLanguageTap,
//     required this.onLogoutTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final tr = AppLocalizations.of(context)!;

//     return Row(
//       children: [
//         Container(
//           height: 56,
//           width: 56,
//           decoration: BoxDecoration(
//             color: theme.colorScheme.primaryContainer,
//             borderRadius: BorderRadius.circular(18),
//           ),
//           child: Icon(
//             Icons.qr_code_scanner_rounded,
//             color: theme.colorScheme.onPrimaryContainer,
//           ),
//         ),

//         const SizedBox(width: 16),

//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 tr.busGateScanner,
//                 style: theme.textTheme.titleLarge?.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),

//               const SizedBox(height: 4),

//               Text(
//                 tr.readyForScanning,
//                 style: theme.textTheme.bodyMedium?.copyWith(
//                   color: theme.colorScheme.onSurfaceVariant,
//                 ),
//               ),
//             ],
//           ),
//         ),

//         PopupMenuButton<String>(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           onSelected: (value) {
//             switch (value) {
//               case "theme":
//                 onThemeTap();
//                 break;

//               case "language":
//                 onLanguageTap();
//                 break;

//               case "logout":
//                 onLogoutTap();
//                 break;
//             }
//           },
//           itemBuilder: (context) {
//             return [
//               PopupMenuItem(value: "theme", child: Text(tr.changeTheme)),

//               PopupMenuItem(value: "language", child: Text(tr.changeLanguage)),

//               const PopupMenuDivider(),

//               PopupMenuItem(value: "logout", child: Text(tr.logout)),
//             ];
//           },
//         ),
//       ],
//     );
//   }
// }

// // =======================================================
// // WIDGET
// // FILE: widgets/scanner_status_card.dart
// // =======================================================

// class ScannerStatusCard extends StatelessWidget {
//   final String status;

//   const ScannerStatusCard({super.key, required this.status});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final tr = AppLocalizations.of(context)!;

//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: theme.colorScheme.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor: theme.colorScheme.primary.withOpacity(.12),
//             child: Icon(Icons.sync_rounded, color: theme.colorScheme.primary),
//           ),

//           const SizedBox(width: 16),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   tr.scannerStatus,
//                   style: theme.textTheme.titleMedium?.copyWith(
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),

//                 const SizedBox(height: 6),

//                 Text(
//                   status,
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                     color: theme.colorScheme.onSurfaceVariant,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // =======================================================
// // WIDGET
// // FILE: widgets/bus_scan_action_card.dart
// // =======================================================

// class BusScanActionCard extends StatefulWidget {
//   final ScanActionType type;
//   final VoidCallback onTap;

//   const BusScanActionCard({super.key, required this.type, required this.onTap});

//   @override
//   State<BusScanActionCard> createState() => _BusScanActionCardState();
// }

// class _BusScanActionCardState extends State<BusScanActionCard>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   bool pressed = false;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1800),
//     )..repeat(reverse: true);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final tr = AppLocalizations.of(context)!;

//     final color = widget.type.color(context);

//     return Expanded(
//       child: GestureDetector(
//         onTapDown: (_) => setState(() => pressed = true),
//         onTapUp: (_) => setState(() => pressed = false),
//         onTapCancel: () => setState(() => pressed = false),
//         onTap: widget.onTap,
//         child: AnimatedScale(
//           duration: const Duration(milliseconds: 180),
//           scale: pressed ? .97 : 1,
//           child: AnimatedBuilder(
//             animation: _controller,
//             builder: (context, _) {
//               return Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(18),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(34),
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       color.withOpacity(.24),
//                       theme.colorScheme.surface.withOpacity(.92),
//                       theme.colorScheme.surface.withOpacity(.96),
//                     ],
//                   ),
//                   border: Border.all(color: color.withOpacity(.35), width: 1.5),
//                   boxShadow: [
//                     BoxShadow(
//                       color: color.withOpacity(.18),
//                       blurRadius: 30 + (_controller.value * 10),
//                       spreadRadius: 1,
//                     ),
//                   ],
//                 ),
//                 child: Stack(
//                   children: [
//                     Positioned(
//                       top: -40,
//                       right: -20,
//                       child: Container(
//                         height: 120,
//                         width: 120,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: color.withOpacity(.12),
//                         ),
//                       ),
//                     ),

//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           height: 64,
//                           width: 64,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(22),
//                             gradient: LinearGradient(
//                               colors: [
//                                 color.withOpacity(.9),
//                                 color.withOpacity(.6),
//                               ],
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: color.withOpacity(.35),
//                                 blurRadius: 20,
//                               ),
//                             ],
//                           ),
//                           child: Icon(
//                             widget.type.icon,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),

//                         const SizedBox(height: 18),

//                         Text(
//                           widget.type.title(tr),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: theme.textTheme.titleLarge?.copyWith(
//                             fontWeight: FontWeight.w900,
//                             letterSpacing: -.4,
//                           ),
//                         ),

//                         const SizedBox(height: 8),

//                         Expanded(
//                           child: Text(
//                             widget.type.subtitle(tr),
//                             maxLines: 3,
//                             overflow: TextOverflow.ellipsis,
//                             style: theme.textTheme.bodyMedium?.copyWith(
//                               height: 1.35,
//                               color: theme.colorScheme.onSurfaceVariant,
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 14),

//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 tr.tapToScan,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                   color: color,
//                                   fontWeight: FontWeight.w800,
//                                   fontSize: 13,
//                                 ),
//                               ),
//                             ),

//                             const SizedBox(width: 8),

//                             TweenAnimationBuilder<double>(
//                               tween: Tween(begin: 0, end: 6),
//                               duration: const Duration(milliseconds: 1200),
//                               curve: Curves.easeInOut,
//                               builder: (_, value, child) {
//                                 return Transform.translate(
//                                   offset: Offset(value, 0),
//                                   child: child,
//                                 );
//                               },
//                               child: Icon(
//                                 Icons.arrow_forward_rounded,
//                                 color: color,
//                                 size: 20,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// // =======================================================
// // WIDGET
// // FILE: widgets/scanner_hint.dart
// // =======================================================

// class ScannerHint extends StatelessWidget {
//   const ScannerHint({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final tr = AppLocalizations.of(context)!;

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           Icons.info_outline_rounded,
//           color: theme.colorScheme.onSurfaceVariant,
//           size: 20,
//         ),

//         const SizedBox(width: 10),

//         Flexible(
//           child: Text(
//             tr.scanInstruction,
//             textAlign: TextAlign.center,
//             style: theme.textTheme.bodyMedium?.copyWith(
//               color: theme.colorScheme.onSurfaceVariant,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // =======================================================
// // SCREEN
// // FILE: scanner/scanner_view.dart
// // =======================================================

// class ScannerView extends StatefulWidget {
//   final ScanActionType type;
//   final Function(String code) onDetect;

//   const ScannerView({super.key, required this.type, required this.onDetect});

//   @override
//   State<ScannerView> createState() => _ScannerViewState();
// }

// class _ScannerViewState extends State<ScannerView>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1800),
//     )..repeat();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final tr = AppLocalizations.of(context)!;

//     final color = widget.type.color(context);

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           MobileScanner(
//             onDetect: (capture) {
//               final code = capture.barcodes.first.rawValue;

//               if (code == null) return;

//               HapticFeedback.mediumImpact();

//               widget.onDetect(code);
//             },
//           ),

//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.black.withOpacity(.8),
//                   Colors.black.withOpacity(.3),
//                   Colors.black.withOpacity(.8),
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),

//           Center(
//             child: SizedBox(
//               width: 280,
//               height: 280,
//               child: Stack(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(32),
//                       border: Border.all(
//                         color: color.withOpacity(.5),
//                         width: 2,
//                       ),
//                     ),
//                   ),

//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Container(
//                       width: 55,
//                       height: 55,
//                       decoration: BoxDecoration(
//                         border: Border(
//                           top: BorderSide(color: color, width: 5),
//                           left: BorderSide(color: color, width: 5),
//                         ),
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(24),
//                         ),
//                       ),
//                     ),
//                   ),

//                   Align(
//                     alignment: Alignment.topRight,
//                     child: Container(
//                       width: 55,
//                       height: 55,
//                       decoration: BoxDecoration(
//                         border: Border(
//                           top: BorderSide(color: color, width: 5),
//                           right: BorderSide(color: color, width: 5),
//                         ),
//                         borderRadius: const BorderRadius.only(
//                           topRight: Radius.circular(24),
//                         ),
//                       ),
//                     ),
//                   ),

//                   Align(
//                     alignment: Alignment.bottomLeft,
//                     child: Container(
//                       width: 55,
//                       height: 55,
//                       decoration: BoxDecoration(
//                         border: Border(
//                           bottom: BorderSide(color: color, width: 5),
//                           left: BorderSide(color: color, width: 5),
//                         ),
//                         borderRadius: const BorderRadius.only(
//                           bottomLeft: Radius.circular(24),
//                         ),
//                       ),
//                     ),
//                   ),

//                   Align(
//                     alignment: Alignment.bottomRight,
//                     child: Container(
//                       width: 55,
//                       height: 55,
//                       decoration: BoxDecoration(
//                         border: Border(
//                           bottom: BorderSide(color: color, width: 5),
//                           right: BorderSide(color: color, width: 5),
//                         ),
//                         borderRadius: const BorderRadius.only(
//                           bottomRight: Radius.circular(24),
//                         ),
//                       ),
//                     ),
//                   ),

//                   AnimatedBuilder(
//                     animation: _controller,
//                     builder: (context, _) {
//                       return Positioned(
//                         top: _controller.value * 240,
//                         left: 20,
//                         right: 20,
//                         child: Container(
//                           height: 4,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             gradient: LinearGradient(
//                               colors: [
//                                 Colors.transparent,
//                                 color,
//                                 Colors.transparent,
//                               ],
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: color.withOpacity(.8),
//                                 blurRadius: 18,
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(22),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(.1),
//                           shape: BoxShape.circle,
//                         ),
//                         child: IconButton(
//                           onPressed: () => Navigator.pop(context),
//                           icon: const Icon(
//                             Icons.arrow_back_ios_new_rounded,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),

//                       const Spacer(),

//                       Text(
//                         widget.type.title(tr),
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 24,
//                           fontWeight: FontWeight.w900,
//                         ),
//                       ),

//                       const Spacer(),

//                       const SizedBox(width: 52),
//                     ],
//                   ),

//                   const Spacer(),

//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 18,
//                       vertical: 14,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(.08),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       tr.placeQrInsideFrame,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700,
//                         fontSize: 15,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 70),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // =======================================================
// // MAIN SCREEN
// // FILE: screens/staff_qr_screen.dart
// // =======================================================

// class StaffQrScreen extends StatefulWidget {
//   const StaffQrScreen({super.key});

//   @override
//   State<StaffQrScreen> createState() => _StaffQrScreenState();
// }

// class _StaffQrScreenState extends State<StaffQrScreen> {
//   bool scanned = false;

//   void _openScanner(ScanActionType type) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => ScannerView(
//           type: type,
//           onDetect: (code) {
//             if (scanned) return;

//             scanned = true;

//             if (type.isEntry) {
//               context.read<StaffQrCubit>().checkIn(code);
//             } else {
//               context.read<StaffQrCubit>().checkOut(code);
//             }

//             Navigator.pop(context);
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final tr = AppLocalizations.of(context)!;

//     return BlocConsumer<StaffQrCubit, StaffQrState>(
//       listener: (context, state) {
//         if (state is StaffQrSuccess) {
//           ShowToastHelper.showToast(context, state.message);
//         }

//         if (state is StaffQrError) {
//           ShowToastHelper.showToast(
//             context,
//             state.message,
//             backgroundColor: theme.colorScheme.error,
//           );
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           backgroundColor: Colors.transparent,
//           body: Stack(
//             children: [
//               // =========================
//               // Background
//               // =========================
//               Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       theme.colorScheme.primary.withOpacity(.08),
//                       theme.colorScheme.surface,
//                       theme.colorScheme.surface,
//                       theme.colorScheme.secondary.withOpacity(.05),
//                     ],
//                   ),
//                 ),
//               ),

//               Positioned(
//                 top: -120,
//                 right: -80,
//                 child: Container(
//                   height: 260,
//                   width: 260,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: theme.colorScheme.primary.withOpacity(.12),
//                   ),
//                 ),
//               ),

//               Positioned(
//                 bottom: -120,
//                 left: -100,
//                 child: Container(
//                   height: 260,
//                   width: 260,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: theme.colorScheme.secondary.withOpacity(.10),
//                   ),
//                 ),
//               ),

//               // =========================
//               // Content
//               // =========================
//               SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 20,
//                   ),
//                   child: LayoutBuilder(
//                     builder: (context, constraints) {
//                       return SingleChildScrollView(
//                         physics: const BouncingScrollPhysics(),
//                         child: ConstrainedBox(
//                           constraints: BoxConstraints(
//                             minHeight: constraints.maxHeight,
//                           ),
//                           child: IntrinsicHeight(
//                             child: Column(
//                               children: [
//                                 // =========================
//                                 // App Bar
//                                 // =========================
//                                 StaffQrAppBar(
//                                   onThemeTap: () {
//                                     context.read<ThemeCubit>().toggleTheme();
//                                   },
//                                   onLanguageTap: () {
//                                     context.read<LocaleCubit>().toggleLocale();
//                                   },
//                                   onLogoutTap: () {
//                                     TokenManager.clearLoginData();

//                                     DioFactory.removeAuthInterceptor();

//                                     context.pushNamedAndRemoveUntil(
//                                       Routes.login,
//                                     );
//                                   },
//                                 ),

//                                 const SizedBox(height: 24),

//                                 // =========================
//                                 // Status Card
//                                 // =========================
//                                 ScannerStatusCard(
//                                   status: tr.systemReadyForScanning,
//                                 ),

//                                 const SizedBox(height: 24),

//                                 // =========================
//                                 // Scan Cards
//                                 // =========================
//                                 Expanded(
//                                   child: Column(
//                                     children: [
//                                       Expanded(
//                                         child: BusScanActionCard(
//                                           type: ScanActionType.entry,
//                                           onTap: () {
//                                             scanned = false;

//                                             _openScanner(ScanActionType.entry);
//                                           },
//                                         ),
//                                       ),

//                                       const SizedBox(height: 18),

//                                       Expanded(
//                                         child: BusScanActionCard(
//                                           type: ScanActionType.exit,
//                                           onTap: () {
//                                             scanned = false;

//                                             _openScanner(ScanActionType.exit);
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),

//                                 // =========================
//                                 // Loading
//                                 // =========================
//                                 AnimatedSwitcher(
//                                   duration: const Duration(milliseconds: 250),
//                                   child: state is StaffQrLoading
//                                       ? Padding(
//                                           padding: const EdgeInsets.only(
//                                             top: 20,
//                                             bottom: 12,
//                                           ),
//                                           child: SizedBox(
//                                             height: 26,
//                                             width: 26,
//                                             child: CircularProgressIndicator(
//                                               strokeWidth: 3,
//                                               color: theme.colorScheme.primary,
//                                             ),
//                                           ),
//                                         )
//                                       : const SizedBox(height: 12),
//                                 ),

//                                 // =========================
//                                 // Hint
//                                 // =========================
//                                 const ScannerHint(),

//                                 const SizedBox(height: 8),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }


