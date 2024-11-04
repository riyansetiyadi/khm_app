import 'package:flutter/material.dart';
import 'package:khm_app/widgets/drawer/main_drawer.dart';
import 'package:khm_app/widgets/navigation_bar/main_app_bar.dart';


class LayananScreen extends StatefulWidget {
  const LayananScreen({super.key});

  @override
  State<LayananScreen> createState() => _LayananScreenState();
}

class _LayananScreenState extends State<LayananScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
              appBar: MainAppBar(
        title: 'SIMKHM',
      ),
      drawer: MainDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: List.generate(cardData.length, (index) {
              return Card(
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7),
                      ),
                      child: Image.network(
                        cardData[index]['image']!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        cardData[index]['title']!,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

final List<Map<String, String>> cardData = [
  {
    'image':
        'https://simkhm.id/assets/img/Screenshot%202024-08-26%20122118.png',
    'title': 'Layanan 24/7',
  },
  {
    'image':
        'https://simkhm.id/assets/img/Screenshot%202024-08-26%20122021.png',
    'title': 'Layanan Apotek',
  },
  {
    'image':
        'https://simkhm.id/assets/img/Screenshot%202024-08-26%20122034.png',
    'title': 'Layanan Akupuntur',
  },
  {
    'image':
        'https://simkhm.id/assets/img/Screenshot%202024-08-26%20122043.png',
    'title': 'Layanan Laboratorium',
  },
  {
    'image':
        'https://simkhm.id/assets/img/Screenshot%202024-08-26%20122048.png',
    'title': 'Layanan Khitan',
  },
  {
    'image':
        'https://simkhm.id/assets/img/Screenshot%202024-08-26%20122053.png',
    'title': 'Layanan Home Care',
  },
];
