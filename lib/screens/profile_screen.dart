import 'package:didatikids/components/button_component.dart';
import 'package:didatikids/screens/add_profile_screen.dart';
import 'package:didatikids/themes/standart.dart';
import 'package:flutter/material.dart';
import 'package:didatikids/utils/form_utils.dart';

class ProfileScreen extends StatelessWidget {
  final String email;
  final String password;

  const ProfileScreen({super.key, required this.email, required this.password});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var frameWidth = MediaQuery.of(context).size.width * 0.80;
    var frameHeight = MediaQuery.of(context).size.height * 0.60;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        color: backgroundMainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "PERFIS",
              style: TextStyle(
                fontSize: 50,
                fontFamily: "Super Funnel",
                color: Colors.yellow,
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: frameWidth,
              height: frameHeight,
              decoration: BoxDecoration(
                color: backgroundSecondColor,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Stack(
                alignment: Alignment.topCenter,
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
                            AddProfileButton(),
                            //Profile(name: 'Júlia', icon: 'duck'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(100),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset('assets/images/icon_$icon.png', width: 150),
          ),
        ),
        // SizedBox(height: 5),
        Text(
          name,
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Super Funnel',
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class AddProfileButton extends StatelessWidget {
  const AddProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddProfile()),
        );
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: const Color.fromARGB(150, 220, 220, 220),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.add, size: 70, color: backgroundMainColor),
      ),
    );
  }
}
