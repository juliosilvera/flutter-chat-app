import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _estaEscribiendo = false;
  List<ChatMessage> _messages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 1,
            backgroundColor: Colors.white,
            title: Column(
              children: [
                CircleAvatar(
                  child: Text(
                    'Te',
                    style: TextStyle(fontSize: 12),
                  ),
                  backgroundColor: Colors.blue[100],
                  maxRadius: 14,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'Fernando',
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                )
              ],
            )),
        body: Container(
          child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (_, i) => _messages[i],
                reverse: true,
              )),
              Divider(
                height: 1,
              ),
              Container(
                color: Colors.white,
                child: _inputChat(),
              )
            ],
          ),
        ));
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(children: [
        Flexible(
            child: TextField(
          controller: _textController,
          onSubmitted: _handleSubmit,
          onChanged: (value) {
            setState(() {
              _estaEscribiendo = value.trim().isNotEmpty;
            });
          },
          decoration: InputDecoration.collapsed(hintText: 'Enviar mensaje'),
          focusNode: _focusNode,
        )),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          child: Platform.isIOS
              ? CupertinoButton(
                  child: Text('Enviar'),
                  onPressed: _estaEscribiendo
                      ? () => _handleSubmit(_textController.text)
                      : null)
              : Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.blue[400]),
                    child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: _estaEscribiendo
                            ? () => _handleSubmit(_textController.text)
                            : null,
                        icon: Icon(Icons.send)),
                  ),
                ),
        )
      ]),
    ));
  }

  _handleSubmit(String texto) {
    print(texto);
    _textController.clear();
    _focusNode.requestFocus();
    final newMessage = ChatMessage(
      texto: texto,
      uid: '123',
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 400)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
