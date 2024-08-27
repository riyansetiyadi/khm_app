import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khm_app/provider/chat_provider.dart';
import 'package:khm_app/utils/enum_state.dart';
import 'package:provider/provider.dart';

class UploadFileChatScreen extends StatefulWidget {
  const UploadFileChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UploadFileChatScreen> createState() => _UploadFileChatScreenState();
}

class _UploadFileChatScreenState extends State<UploadFileChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Preview'),
        actions: [
          Consumer<ChatProvider>(
            builder: (context, state, _) {
              switch (state.state) {
                case ResultState.loading:
                  return Center(
                    child: defaultTargetPlatform == TargetPlatform.iOS
                        ? const CupertinoActivityIndicator(
                            radius: 20.0,
                          )
                        : const CircularProgressIndicator(),
                  );
                case ResultState.initial:
                  return Container();
                case ResultState.error:
                  return Container();
                case ResultState.loaded:
                  if (state.image == null) {
                    return Container();
                  } else {
                    return TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Text('Upload',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF198754))),
                    );
                  }
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
          onPressed: () async {
            final chatProvider = context.read<ChatProvider>();
            await chatProvider.pickImage();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF198754).withOpacity(0.5),
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, 36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt),
              SizedBox(width: 10),
              Text('Ambil Foto Ulang',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            ],
          )),
      body: Consumer<ChatProvider>(
        builder: (context, state, _) {
          switch (state.state) {
            case ResultState.loading:
              return Center(
                child: defaultTargetPlatform == TargetPlatform.iOS
                    ? const CupertinoActivityIndicator(
                        radius: 20.0,
                      )
                    : const CircularProgressIndicator(),
              );
            case ResultState.initial:
              return Container();
            case ResultState.error:
              return Container();
            case ResultState.loaded:
              if (state.image == null) {
                return Container();
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      state.image == null
                          ? Text('No image selected.')
                          : Image.file(
                              state.image!,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
