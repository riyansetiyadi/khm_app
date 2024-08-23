import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khm_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class AddRoomScreen extends StatefulWidget {

  const AddRoomScreen({
    Key? key,
  }) : super(key: key);

  @override
  _AddRoomScreenState createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  List<Widget> buttons = [];

  void _addDateButton() {
              context.go('/chat');
    // DateTime now = DateTime.now();
    // String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    // String formattedTime = DateFormat('HH:mm:ss').format(now);

    // setState(() {
    //   buttons.add(
    //     ElevatedButton(
    //       style: ElevatedButton.styleFrom(
    //         elevation: 3,
    //         minimumSize: Size(double.infinity, 36),
    //         backgroundColor: Colors.white,
    //         foregroundColor: Color(0xFF198754),
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(6.0),
    //         ),
    //       ),
    //       onPressed: () {
    //         widget.onTapped(AppPage.chat);
    //       },
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Text(
    //             '$formattedDate',
    //             style: TextStyle(
    //               fontSize: 15,
    //             ),
    //           ),
    //           SizedBox(width: 4),
    //           Text(
    //             '$formattedTime',
    //             style: TextStyle(
    //               fontSize: 15,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    final authWatch = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Konsultasi ${authWatch.profile?.fullname ?? ''}'),
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Card(
              color: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        minimumSize: Size(double.infinity, 36),
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xFF198754),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      onPressed: _addDateButton,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 8),
                          Text('[',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          Icon(
                            Icons.add,
                            color: Color(0xFF198754),
                          ),
                          Text(']',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          SizedBox(width: 8),
                          Text('Konsultasi Baru',
                              style: TextStyle(
                                fontSize: 15,
                              ))
                        ],
                      ),
                    ),
                    ...buttons,
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
