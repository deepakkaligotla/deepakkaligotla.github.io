import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final String name;
  final String username;
  final String bio;
  final int followers;
  final int following;

  const ProfileInfo({
    Key? key,
    required this.name,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: Theme.of(context).textTheme.headlineSmall),
        Text('@$username', style: TextStyle(color: Colors.grey)),
        SizedBox(height: 8),
        Text(bio, style: TextStyle(fontSize: 14)),
        SizedBox(height: 12),
        Row(
          children: [
            _buildStatItem("$followers", "Followers"),
            SizedBox(width: 16),
            _buildStatItem("$following", "Following"),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Row(
      children: [
        Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 4),
        Text(label, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}