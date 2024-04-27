import 'package:flutter/material.dart';

import 'chat_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const ChatScreen(),
                  ),
                );
              },
              child: const Text("Chat"),
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () {},
              child: const Text("Image"),
            ),
          ],
        ),
      ),
    );
  }
}
