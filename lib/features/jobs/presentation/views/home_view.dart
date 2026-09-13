import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffFAF8F4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [Row(children: [
                  
                ],
              )]),
        ),
      ),
    );
  }
}
