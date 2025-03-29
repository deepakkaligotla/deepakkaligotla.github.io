import 'package:flutter/material.dart';

class RepoCard extends StatelessWidget {
  final String repoName;
  final String description;
  final int stars;
  final int forks;

  const RepoCard({
    Key? key,
    required this.repoName,
    required this.description,
    required this.stars,
    required this.forks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(repoName, style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 4),
            Text(description, style: TextStyle(color: Colors.grey)),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.star, size: 16, color: Colors.amber),
                SizedBox(width: 4),
                Text("$stars"),
                SizedBox(width: 16),
                Icon(Icons.fork_right, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text("$forks"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}