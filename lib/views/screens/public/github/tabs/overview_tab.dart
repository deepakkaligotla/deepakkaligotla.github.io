import 'package:flutter/material.dart';
import 'package:deepakkaligotla/views/widgets/contribution_activity.dart';
import 'package:deepakkaligotla/views/widgets/popular_repositories.dart';
import 'package:deepakkaligotla/views/widgets/contributions_overview.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PopularRepositories(
            repositories: [
              {
                "name": "Flutter UI",
                "description": "A cool Flutter UI project",
                "language": "Dart",
                "stars": 10,
              },
              {
                "name": "Firebase Auth",
                "description": "Authentication with Firebase",
                "language": "Dart",
                "stars": 20,
              },
              // Add more repositories...
            ],
          ),
          ContributionsOverview(
            contributions: 23,
            contributionGraph: const Text(
              "GraphQL for contributions data",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ContributionActivity()
        ],
      ),
    );
  }
}