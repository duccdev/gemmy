import 'package:flutter/material.dart';
import 'package:gemmy/types/message.dart';
import 'package:gemmy/utils/pad_widgets.dart';
import 'package:gemmy/widgets/ez/message.dart';
import 'package:gemmy/widgets/ez/text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Message> _msgs = [
    const Message(role: 'user', content: 'ass'),
    const Message(role: 'assistant', content: 'bro wtf :skull:')
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 16, left: 16),
      child: Column(
        children: [
          Column(
            children: padWidgets(
              const EdgeInsets.only(bottom: 16),
              _msgs.map((msg) => EzMessage(message: msg)).toList(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: EzText('arse'),
          ),
        ],
      ),
    );
  }
}
