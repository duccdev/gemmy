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
  bool _step1Enabled = true;
  bool _step2Enabled = false;
  bool _step2Loading = false;

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
                enabled: _step1Enabled,
                hintText: 'I\'m not looking!',
                obscureText: true,
                disableSubmitButton: true,
                onChanged: (text) {
                  text = text.trim();

                  if (text.isEmpty) {
                    Globals.apiKey = null;
                    Globals.prefs.remove('apiKey');
                    setState(() => _step2Enabled = false);
                    return;
                  }

                  Globals.apiKey = text;
                  Globals.prefs.setString('apiKey', text);
                  setState(() => _step2Enabled = true);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const EzText('Step 2: '),
                SizedBox(
                  width: 150,
                  child: EzButton(
                    onPressed: _step2Enabled
                        ? () => setState(() {
                              _step1Enabled = false;
                              _step2Enabled = false;
                              _step2Loading = true;
                            })
                        : null,
                    child: _step2Loading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(),
                          )
                        : EzText(
                            'Connect',
                            color:
                                _step2Enabled ? Colors.white : Colors.white54,
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
