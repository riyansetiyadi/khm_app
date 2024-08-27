import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khm_app/models/chat_model.dart';
import 'package:khm_app/provider/auth_provider.dart';
import 'package:khm_app/provider/chat_provider.dart';
import 'package:khm_app/utils/enum_state.dart';
import 'package:khm_app/widgets/handle_error_refresh_widget.dart';
import 'package:khm_app/widgets/unauthorized_widget.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final String? idRoom;

  const ChatScreen({
    Key? key,
    String? this.idRoom,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late ChatProvider chatProvider;

  Timer? _timer;
  // bool _isPickingFile = false;

  String? _idRoom;

  @override
  void initState() {
    chatProvider = context.read<ChatProvider>();
    if (widget.idRoom != null) {
      _idRoom = widget.idRoom;
      chatProvider.getMessage(_idRoom!);
    }
    _getMessageByTimer();
    super.initState();
  }

  void _getMessageByTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_idRoom != null) {
        chatProvider.refreshMessage();
        print('refresss');
      }
      print('yyyy');
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _idRoom = null;
    chatProvider.resetChat();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_idRoom == null) {
      await chatProvider.addRoom();
      setState(() {
        _idRoom = chatProvider.roomChat?.id;
      });
    }

    final String message = _messageController.text;
    File? img = chatProvider.image;

    await chatProvider.sendMessage(message, img: img);
    await chatProvider.refreshMessage();
    chatProvider.image = null;

    setState(() {
      _messageController.clear();
    });
    _scrollToBottom();
  }

  // void _pickFile() async {
  //   setState(() {
  //     _isPickingFile = true;
  //   });

  //   final result = await FilePicker.platform.pickFiles();

  //   setState(() {
  //     _isPickingFile = false;
  //   });

  //   if (result != null) {
  //     // final fileName = result.files.single.name;
  //     // setState(() {
  //     //   _messages.add("File selected: $fileName");
  //     // });
  //     _scrollToBottom();
  //   }
  // }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Widget _buildMessageBubble(ChatModel message) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: (message.dari == 'pasien')
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: message.chat.startsWith("File selected: ")
                  ? Colors.greenAccent
                  : Color(0xFF198754),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Text(
              message.chat,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authWatch = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Konsultasi ${authWatch.profile?.fullname ?? ''}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  if (chatProvider.roomChat?.chats?.last.dari == 'pasien')
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Menunggu respon dokter'),
                      ),
                    ),
                  if (chatProvider.roomChat != null)
                    Container(
                      width: double.infinity,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 4,
                        margin: EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: containerMessages(
                              chatProvider.roomChat?.chats ?? []),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (chatProvider.image != null)
            Image.file(
              chatProvider.image!,
              width: 50,
              fit: BoxFit.cover,
            ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: CircularProgressIndicator(),
          // ),
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 4,
              margin: EdgeInsets.all(8),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: () async {
                      await chatProvider.pickImage();
                      context.push('/addroom/chat/filechat');
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFCED4DA)),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget containerMessages(List<ChatModel> messages) {
    return Column(
      children:
          messages.map((message) => _buildMessageBubble(message)).toList(),
    );
  }
}
