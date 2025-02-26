import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deepakkaligotla/providers/flutter_secure_storage.dart';
import 'package:deepakkaligotla/providers/model_provider.dart';

class ThemeToggle extends StatefulWidget {
  const ThemeToggle({super.key});

  @override
  State<ThemeToggle> createState() => _ThemeToggle();
}

class _ThemeToggle extends State<ThemeToggle> {
  Offset offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final finalData = Provider.of<LocalStorageProvider>(context, listen: true).localStorage;

    return Stack(
      children: [
        Positioned(
          right: offset.dx + 5,
          bottom: offset.dy + kBottomNavigationBarHeight + 5,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                offset += Offset(-details.delta.dx, -details.delta.dy);
              });
            },
            child: IconButton(
              icon: Icon(Icons.brightness_7,
              color: finalData.userDetails.sysDefaultTheme == ThemeMode.dark ? Colors.black : Colors.white, size: 36),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    return finalData.userDetails.userColorScheme!.inverseSurface;
                  },
                ),
              ),
              onPressed: () {
                Provider.of<ModelProvider>(context, listen: false).toggleTheme();
              },
            ),
          ),
        ),
      ],
    );
  }
}
