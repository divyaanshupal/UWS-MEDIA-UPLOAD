import 'package:flutter/material.dart';
import 'package:uws/Screens/LoginPage.dart';
import 'package:uws/Screens/OtherScreen.dart';
import 'package:uws/Screens/SchoolScreen.dart';

class MainLayout extends StatelessWidget {
  final Widget body;

  const MainLayout({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 119, 177, 232),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 78,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 249, 249, 249),
                ),
                child: Image.asset(
                  'assets/unnati moto.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LandingPageScreen()),
                );
              },
              leading: const Icon(Icons.home),
              title: const Text('Home'),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SchoolSelectionScreen()),
                );
              },
              leading: const Icon(Icons.school),
              title: const Text('Schools'),
            ),
            ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Otherscreen()),
                  );
                },
                leading: const Icon(Icons.arrow_right),
                title: const Text("Other Programs"))
          ],
        ),
      ),
      body: Stack(
        children: [
          body, // Main content
          Positioned(
            top: 16,
            left: 16,
            child: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu,
                    size: 30, color: Color.fromARGB(255, 248, 246, 246)),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
