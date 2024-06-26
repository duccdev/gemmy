import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemmy/types/message.dart';
import 'package:gemmy/widgets/ez/text.dart';

class EzMessage extends StatelessWidget {
  const EzMessage({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
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
                EzText(message.role == 'assistant' ? 'Gemini' : 'You',
                    fontSize: 20, bold: true),
                EzText(
                  message.content,
                  fontSize: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
