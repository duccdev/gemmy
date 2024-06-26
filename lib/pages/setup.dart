import 'package:flutter/material.dart';
import 'package:gemmy/globals.dart';
import 'package:gemmy/widgets/ez/text.dart';
import 'package:gemmy/widgets/ez/textfield.dart';

class SetupPage extends StatelessWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: EzText('Step 1: Add your API key'),
          ),
          SizedBox(
            width: 512,
            child: EzTextField(
              hintText: 'I\'m not looking!',
              obscureText: true,
              disableSubmitButton: true,
              onChanged: (text) {
                if (text.trim().isEmpty) {
                  Globals.apiKey = null;
                  Globals.prefs.remove('apiKey');
                  return;
                }

                Globals.apiKey = text.trim();
                Globals.prefs.setString('apiKey', text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
