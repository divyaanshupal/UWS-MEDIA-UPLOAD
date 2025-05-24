// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
                GoRouter.of(context).go('/');
              },
              leading: const Icon(Icons.home),
              title: const Text('Home'),
            ),
            ListTile(
              onTap: () {
                GoRouter.of(context).go('/schools');
              },
              leading: const Icon(Icons.school),
              title: const Text('Schools'),
            ),
            ListTile(
                onTap: () {
                  GoRouter.of(context).go('/programs');
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
