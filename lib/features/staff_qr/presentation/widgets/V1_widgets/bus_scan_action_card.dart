
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../screens/staff_qr_screen.dart';

class BusScanActionCard extends StatefulWidget {
  final ScanActionType type;
  final VoidCallback onTap;

  const BusScanActionCard({super.key, required this.type, required this.onTap});

  @override
  State<BusScanActionCard> createState() => _BusScanActionCardState();
}

class _BusScanActionCardState extends State<BusScanActionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool pressed = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tr = AppLocalizations.of(context)!;

    final color = widget.type.color(context);

    return Expanded(
      child: GestureDetector(
        onTapDown: (_) => setState(() => pressed = true),
        onTapUp: (_) => setState(() => pressed = false),
        onTapCancel: () => setState(() => pressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 180),
          scale: pressed ? .97 : 1,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color.withOpacity(.24),
                      theme.colorScheme.surface.withOpacity(.92),
                      theme.colorScheme.surface.withOpacity(.96),
                    ],
                  ),
                  border: Border.all(color: color.withOpacity(.35), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(.18),
                      blurRadius: 30 + (_controller.value * 10),
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -40,
                      right: -20,
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color.withOpacity(.12),
                        ),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 64,
                          width: 64,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            gradient: LinearGradient(
                              colors: [
                                color.withOpacity(.9),
                                color.withOpacity(.6),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: color.withOpacity(.35),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: Icon(
                            widget.type.icon,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),

                        const SizedBox(height: 18),

                        Text(
                          widget.type.title(tr),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            letterSpacing: -.4,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Expanded(
                          child: Text(
                            widget.type.subtitle(tr),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.35,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                tr.tapToScan,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: color,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                ),
                              ),
                            ),

                            const SizedBox(width: 8),

                            TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0, end: 6),
                              duration: const Duration(milliseconds: 1200),
                              curve: Curves.easeInOut,
                              builder: (_, value, child) {
                                return Transform.translate(
                                  offset: Offset(value, 0),
                                  child: child,
                                );
                              },
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: color,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// =======================================================
// WIDGET
// FILE: widgets/scanner_hint.dart
// =======================================================

class ScannerHint extends StatelessWidget {
  const ScannerHint({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tr = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.info_outline_rounded,
          color: theme.colorScheme.onSurfaceVariant,
          size: 20,
        ),

        const SizedBox(width: 10),

        Flexible(
          child: Text(
            tr.scanInstruction,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
