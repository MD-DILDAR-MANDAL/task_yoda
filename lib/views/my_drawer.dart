import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFFA8D1A1),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/drawer.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Thanks for using this app',
              style: TextStyle(fontSize: 18, color: Color(0xFF2F4F4F)),
            ),

            const SizedBox(height: 40),

            const Text(
              'Visit \n Galactic Market \n (https://irozer.github.io) \n for more...',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),

            const SizedBox(height: 40),

            Text(
              'Free Thought Free World',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 18,
                color: Color(0xFF2F4F4F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
