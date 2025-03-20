import 'package:didatikids/themes/standart.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String email;
  final String password;

  const ProfileScreen({super.key, required this.email, required this.password});

  @override
  Widget build(BuildContext context) {
    var frameWidth = MediaQuery.of(context).size.width * 0.80;
    var frameHeight = MediaQuery.of(context).size.height * 0.60;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: backgroungMainColor,
        child: Container(
          width: frameWidth,
          height: frameHeight,
          decoration: BoxDecoration(
            color: backgroundSecondColor,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Profile(name: 'Caio', icon: 'dog'),
                        Profile(name: 'Hellena', icon: 'uni'),
                      ],
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Profile(name: 'Noah', icon: 'robot'),
                        Profile(name: 'Júlia', icon: 'duck'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  final String name;
  final String icon;
  const Profile({super.key, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset('assets/images/icon_$icon.png', width: 150),
        ),
        Text(name, style: TextStyle(fontSize: 25, color: Colors.white)),
      ],
    );
  }
}
