import 'package:flutter/material.dart';

class ContributionsOverview extends StatelessWidget {
  final int contributions;
  final Widget contributionGraph;

  const ContributionsOverview({
    Key? key,
    required this.contributions,
    required this.contributionGraph,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$contributions contributions in 2025",
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Card(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 400,
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: Center(
                      child: contributionGraph,
                    ),
                  ),
                  const Divider(color: Colors.grey, height: 1),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Activity Overview", style: TextStyle(color: Colors.white)),
                        ),
                        VerticalDivider(color: Colors.grey, width: 1),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Graph", style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}