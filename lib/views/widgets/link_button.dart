import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkButton extends StatelessWidget {
  final String url;
  final IconData icon;
  final String label;

  const LinkButton({
    Key? key,
    required this.url,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Could not open link")),
          );
        }
      },
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}