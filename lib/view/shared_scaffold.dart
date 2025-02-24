import 'package:flutter/material.dart';
import 'app_search.dart';

class SharedScaffold extends StatefulWidget {
  final VoidCallback onThemeChange;
  final ColorScheme userTheme;
  final double screenHeight;
  final double screenWidth;
  final Widget content;

  const SharedScaffold({
    super.key,
    required this.onThemeChange,
    required this.userTheme,
    required this.screenHeight,
    required this.screenWidth,
    required this.content,
  });

  @override
  _SharedScaffoldState createState() => _SharedScaffoldState();
}

class _SharedScaffoldState extends State<SharedScaffold> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/services');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/privacy_policy');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppSearch(),
        backgroundColor: widget.userTheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              widget.onThemeChange();
            },
          ),
        ],
      ),
      drawer: Drawer(
        width: widget.screenWidth / 2.5,
        backgroundColor: widget.userTheme.surface,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: widget.userTheme.primary,
              ),
              child: Image.network('https://raw.githubusercontent.com/deepakkaligotla/deepakkaligotla.github.io/refs/heads/main/assets/images/logo.png'),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
              },
            ),
            ListTile(
              title: const Text('Services'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
              },
            ),
            ListTile(
              title: const Text('Privacy Policy'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: widget.userTheme.surface,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: widget.userTheme.secondary,
        unselectedItemColor: widget.userTheme.onSurface,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_filled),
            tooltip: 'Home Screen',
          ),
          BottomNavigationBarItem(
            label: 'Services',
            icon: Icon(Icons.design_services_outlined),
            activeIcon: Icon(Icons.design_services),
            tooltip: 'Services Screen',
          ),
          BottomNavigationBarItem(
            label: 'Privacy Policy',
            icon: Icon(Icons.policy_outlined),
            activeIcon: Icon(Icons.policy),
            tooltip: 'Privacy Policy Screen',
          ),
        ],
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 0, maxWidth: widget.screenWidth, minHeight: 0, maxHeight: widget.screenHeight),
        child: widget.content,
      ),
    );
  }
}