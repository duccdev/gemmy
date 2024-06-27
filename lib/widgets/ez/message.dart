import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemmy/types/message.dart';
import 'package:gemmy/widgets/ez/text.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
                  ? const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: SizedBox(
                        width: 256,
                        child: LinearProgressIndicator(
                          color: Colors.blue,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    )
                  : MarkdownBody(
                      selectable: true,
                      data: message.content.trim(),
                      styleSheet: MarkdownStyleSheet(
                        p: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        h1: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        h2: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        h3: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        h4: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        h5: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        h6: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        code: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          backgroundColor: Colors.black,
                          fontFamily: 'monospace',
                        ),
                        listBullet: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        codeblockDecoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onTapLink: (_, href, __) async {
                        if (href != null && await canLaunchUrlString(href)) {
                          await launchUrlString(href);
                        }
                      },
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
