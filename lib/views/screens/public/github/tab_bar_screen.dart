import 'package:flutter/material.dart';
import 'tabs/overview_tab.dart';

class GitTabBar extends StatefulWidget {
  const GitTabBar({super.key});

  @override
  State<GitTabBar> createState() => _GitTabBarState();
}

class _GitTabBarState extends State<GitTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(icon: Icon(Icons.menu_book_sharp), text: "Overview"),
            Tab(icon: Icon(Icons.book_outlined), text: "Repositories"),
            Tab(icon: Icon(Icons.crop_square_outlined), text: "Projects"),
            Tab(icon: Icon(Icons.crop_square_outlined), text: "Packages"),
            Tab(icon: Icon(Icons.star_outline_sharp), text: "Stars"),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              OverviewTab(),
              SingleChildScrollView(child: Center(child: Text("Repositories"))),
              SingleChildScrollView(child: Center(child: Text("Projects"))),
              SingleChildScrollView(child: Center(child: Text("Packages"))),
              SingleChildScrollView(child: Center(child: Text("Stars"))),
            ],
          ),
        ),
      ],
    );
  }
}