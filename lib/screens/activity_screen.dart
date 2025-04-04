import 'package:didatikids/themes/standart.dart';
import 'package:flutter/material.dart';

class TelaAtividades extends StatelessWidget {
  const TelaAtividades({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
        color: backgroundMainColor, size: 30),
        centerTitle: true,
        title: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => TelaAtividades()));},
          icon: Icon(
            Icons.house,
            color: backgroundMainColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(
              Icons.settings,
              color: backgroundMainColor
            )
          )
        ],
      ),
      body: Container(
        color: backgroundMainColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0), // Espaçamento superior
              child: Text(
                'Atividades',
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'Super Funnel',
                  color: Colors.yellow,
                ),
              ),
            ),
            const SizedBox(height: 20), // Espaçamento entre o texto e as atividades
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Activity(
                        activityName: "Matemática",
                        activityColor: '0xFF009CF3',
                      ),
                      Activity(
                        activityName: "Português",
                        activityColor: '0xFFFFE500',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Activity(
                        activityName: "Lógica",
                        activityColor: '0xFF5da2e8',
                        activityIcon: Icons.calculate,
                      ),
                      Activity(
                        activityName: "História",
                        activityColor: '0xFFfc7703',
                        activityIcon: Icons.menu_book,
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


class Activity extends StatelessWidget {
    final String activityName;
    final String activityColor;
    final IconData? activityIcon;
    const Activity({super.key, required this.activityName, required this.activityColor, this.activityIcon });

  @override
  Widget build(BuildContext context) {
      return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            color: Color(int.parse(activityColor)),
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(onTap: (){
            // Navigator.push(
            //   context, MaterialPageRoute(builder: (context) => TelaAtividades()));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1),
              child: activityIcon == null
                ? Text(
                  activityName.contains("Matemática") ? "123" : "ABC",
                  style: TextStyle(
                    fontSize: 35,
                    fontFamily: 'Super Funnel',
                    color: Colors.white,
                  ),
                )
                : Icon(activityIcon, size: 60, color: Colors.white,)
            ),
          )
        ),
        SizedBox(height: 5),
        Text(
          activityName,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Super Funnel',
            color: Colors.white,
          ),
        ),
      ],
    );

  }
}