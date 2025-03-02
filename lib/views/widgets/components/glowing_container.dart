import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deepakkaligotla/providers/flutter_secure_storage.dart';

class GlowingContainer extends StatefulWidget {
  final Widget child;
  const GlowingContainer({super.key, required this.child});

  @override
  State<GlowingContainer> createState() => _GlowingContainerState();
}

class _GlowingContainerState extends State<GlowingContainer>  with TickerProviderStateMixin {
  late bool _isHovered;

  @override
  void initState() {
    super.initState();
    _isHovered = false;
  }

  @override
  void dispose() {
    _isHovered = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final finalData = Provider.of<LocalStorageProvider>(context, listen: true).localStorage;

    return SizedBox(
      width: 360,
      height: 240,
      child: Center(
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.teal.shade900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: _isHovered
                  ? [
                BoxShadow(
                  color: Colors.purpleAccent,
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ]
                  : [],
            ),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 360,
                maxHeight: 240,
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: finalData.userDetails.userColorScheme!.outline,
                ),
              ),
              child: Center(
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}