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
  ChatSession _chat = Globals.model!.startChat();
  final List<Message> _msgs = List.empty(growable: true);
  bool _chatInputEnabled = true;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[
              Column(
                children: padWidgets(
                  const EdgeInsets.only(bottom: 16),
                  _msgs
                      .asMap()
                      .entries
                      .map((e) => EzMessage(
                            message: e.value,
                            regenerateCallback: e.key == (_msgs.length - 1)
                                ? () async {
                                    setState(() {
                                      _msgs.last.generating = true;
                                      _chatInputEnabled = false;
                                      _msgs.last.content = '';
                                    });

                                    List<Content> history =
                                        _chat.history.toList();
                                    history.removeLast();
                                    history.removeLast();

                                    _chat = Globals.model!
                                        .startChat(history: history);
                                    final response = _chat.sendMessageStream(
                                      Content.text(
                                          _msgs[_msgs.length - 2].content),
                                    );
                                    await for (final chunk in response) {
                                      setState(() => _msgs.last.content = _msgs
                                              .last.content
                                              .trim()
                                              .isEmpty
                                          ? chunk.text!
                                          : _msgs.last.content + chunk.text!);
                                    }

                                    setState(() {
                                      _msgs.last.generating = false;
                                      _chatInputEnabled = true;
                                    });
                                  }
                                : null,
                          ))
                      .toList(),
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
                      _msgs.add(Message(
                          role: 'user', content: text, generating: false));
                      _msgs.add(Message(
                          role: 'assistant', content: '', generating: true));
                    });

                    final response =
                        _chat.sendMessageStream(Content.text(text));
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
        ),
      ),
    );
  }
}
