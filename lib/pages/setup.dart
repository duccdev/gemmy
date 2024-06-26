import 'package:flutter/material.dart';
import 'package:gemmy/globals.dart';
import 'package:gemmy/utils/pad_widgets.dart';
import 'package:gemmy/widgets/ez/button.dart';
import 'package:gemmy/widgets/ez/text.dart';
import 'package:gemmy/widgets/ez/textfield.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  bool _step2Disabled = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: padWidgets(
          const EdgeInsets.only(bottom: 16),
          <Widget>[
            const EzText('Step 1: Add your API key'),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const EzText('Step 2: '),
                EzButton(
                    onPressed: _step2Disabled ? null : () {},
                    child: EzText('Connect',
                        color: _step2Disabled ? Colors.white54 : Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
