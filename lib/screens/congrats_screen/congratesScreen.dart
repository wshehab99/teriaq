import 'package:find_doctor/screens/gridpage/gridpage.dart';
import 'package:find_doctor/shared/app_button.dart';
import 'package:flutter/material.dart';

class CongratsScreen extends StatelessWidget {
  const CongratsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Spacer(),
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 100,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image(
                image: AssetImage(
                  'assets/images/Dawiny logo - 2.png',
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Congrats! ',
            style: TextStyle(
                fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Your Account is ready to use',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 24,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: AppButton(
              text: 'Go To Homepage',
              borderradius: BorderRadius.circular(90),
              textColor: Colors.white,
              bottenColor: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GridPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
