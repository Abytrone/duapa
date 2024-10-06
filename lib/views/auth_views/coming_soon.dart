import 'package:flutter/material.dart';

class CoomingSoonScreen extends StatelessWidget {
  const CoomingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Title(
          color: Colors.white,
          child: const Text(
            'Duapa App',
            style: TextStyle(fontFamily: 'Gotik'),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/coming-soon.png",
                height: 200.0,
              ),
              // Text(
              //   'Coming Soon!',
              //   style: TextStyle(
              //     color: Colors.green,
              //     fontFamily: 'Gotik',
              //     fontSize: 25,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                '- on next update -',
                style: TextStyle(
                  color: Colors.green,
                  fontFamily: 'Gotik',
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
