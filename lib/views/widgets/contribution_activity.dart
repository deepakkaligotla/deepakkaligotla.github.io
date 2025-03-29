import 'package:flutter/material.dart';

class ContributionActivity extends StatefulWidget {
  const ContributionActivity({super.key});

  @override
  State<ContributionActivity> createState() => ContributionActivityState();
}

class ContributionActivityState extends State<ContributionActivity> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.all(16),
            child: Text("Contribution Activity", style: TextStyle(fontSize: 20, color: Colors.white)),
        ),
        Row(
          children: [
            Text("March 2025",style: TextStyle(fontSize: 14, color: Colors.white)),
            SizedBox(width: MediaQuery.of(context).size.width-600, height: 1,
                child: Container(color: Colors.grey)
            )
          ],
        )
      ],
    );
  }
}