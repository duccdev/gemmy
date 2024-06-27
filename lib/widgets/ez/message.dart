import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemmy/types/message.dart';
import 'package:gemmy/widgets/ez/text.dart';

typedef RegenerateCallback = Future<void> Function();

class EzMessage extends StatelessWidget {
  const EzMessage({
    super.key,
    required this.message,
    required this.regenerateCallback,
  });

  final Message message;
  final RegenerateCallback? regenerateCallback;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        message.role == 'assistant'
            ? ClipOval(
                child: SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              )
            : Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.person,
                    size: 32,
                    color: Colors.black,
                  ),
                ),
              ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              EzText(
                message.role == 'assistant' ? 'Gemini' : 'You',
                fontSize: 20,
                bold: true,
              ),
              message.content.trim().isEmpty
                  ? const EzText(
                      'Generating...',
                      color: Colors.blue,
                      fontSize: 20,
                    )
                  : MarkdownBody(
                      selectable: true,
                      data: message.content.trim(),
                      styleSheet: MarkdownStyleSheet(
                        p: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                        code: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          backgroundColor: Colors.black,
                          fontFamily: 'monospace',
                        ),
                        codeblockDecoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        listBullet: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      extensionSet: md.ExtensionSet(
                        md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                        <md.InlineSyntax>[
                          md.EmojiSyntax(),
                          ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
                        ],
                      ),
                    ),
              message.role == 'assistant' && !message.generating
                  ? Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: message.content));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: EzText('Copied to clipboard!'),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.copy,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                          regenerateCallback != null
                              ? IconButton(
                                  onPressed: regenerateCallback,
                                  icon: const Icon(
                                    Icons.refresh,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ],
    );
  }
}
