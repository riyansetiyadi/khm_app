import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khm_app/widgets/drawer/main_drawer.dart';
import 'package:khm_app/widgets/navigation_bar/main_app_bar.dart';

class PendaftaranPoliScreen extends StatefulWidget {
  const PendaftaranPoliScreen({super.key});

  @override
  State<PendaftaranPoliScreen> createState() => _PendaftaranPoliScreenState();
}

class _PendaftaranPoliScreenState extends State<PendaftaranPoliScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'SIMKHM',
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Text(
            'Pendaftaran Poli Online',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.network(
                      'https://wedangtech.my.id/WhatsApp%20Image%202024-07-15%20at%2015.04.18.jpeg',
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Klinik Husada Mulia Wonorejo',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          context.push('/home');
                        },
                        child: Text('Kunjungi'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
