import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:khm_app/provider/auth_provider.dart';
import 'package:khm_app/provider/chat_provider.dart';
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
  final List<String> _messages = ['ss', 'pppp'];
  final ScrollController _scrollController = ScrollController();

  bool _isPickingFile = false;

  late String? _idRoom;

  @override
  void initState() {
    super.initState();
    _idRoom = widget.idRoom;
  }

  void _sendMessage() {
    if (_idRoom == null) {
      final chatProvider = context.read<ChatProvider>();
      chatProvider.addRoom();
      chatProvider.sendMessage();
    }
    final message = _messageController.text;
    if (message.isNotEmpty) {
      setState(() {
        _messages.add(message);
        _messageController.clear();
      });
      _scrollToBottom();
    }
  }

  void _pickFile() async {
    setState(() {
      _isPickingFile = true;
    });

    final result = await FilePicker.platform.pickFiles();

    setState(() {
      _isPickingFile = false;
    });

    if (result != null) {
      final fileName = result.files.single.name;
      setState(() {
        _messages.add("File selected: $fileName");
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Widget _buildMessageBubble(String message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: message.startsWith("File selected: ")
            ? Colors.greenAccent
            : Color(0xFF198754),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Text(
        message,
        style: TextStyle(color: Colors.white),
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
                  if (widget.idRoom != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Menunggu respon dokter'),
                      ),
                    ),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: _messages
                              .map((message) => _buildMessageBubble(message))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isPickingFile)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
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
                    onPressed: _pickFile,
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
}
