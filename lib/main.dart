import 'package:flutter/material.dart';

void main() {
  runApp(const MusicOSApp());
}

class MusicOSApp extends StatelessWidget {
  const MusicOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MusicOS',
      debugShowCheckedModeBanner: false,
      home: _PlaceholderPage(),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'MusicOS',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Under Development',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
