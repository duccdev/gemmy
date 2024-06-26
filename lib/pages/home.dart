import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:gemmy/globals.dart';
import 'package:gemmy/types/message.dart';
import 'package:gemmy/utils/pad_widgets.dart';
import 'package:gemmy/widgets/ez/message.dart';
import 'package:gemmy/widgets/ez/textfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatSession _chat = Globals.model!.startChat();
  final List<Message> _msgs = List.empty(growable: true);
  bool _chatInputEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          Column(
            children: padWidgets(
              const EdgeInsets.only(bottom: 16),
              _msgs.map((msg) => EzMessage(message: msg)).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: EzTextField(
              enabled: _chatInputEnabled,
              hintText: 'Enter a prompt here',
              onSubmitted: (text) async {
                setState(() {
                  _chatInputEnabled = false;
                  _msgs.add(
                      Message(role: 'user', content: text, generating: false));
                  _msgs.add(Message(
                      role: 'assistant', content: '', generating: true));
                });

                final response = _chat.sendMessageStream(Content.text(text));
                await for (final chunk in response) {
                  setState(() => _msgs.last.content =
                      _msgs.last.content.trim().isEmpty
                          ? chunk.text!
                          : _msgs.last.content + chunk.text!);
                }

                setState(() {
                  _msgs.last.generating = false;
                  _chatInputEnabled = true;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
