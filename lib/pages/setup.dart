// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gemmy/globals.dart';
import 'package:gemmy/utils/pad_widgets.dart';
import 'package:gemmy/widgets/ez/button.dart';
import 'package:gemmy/widgets/ez/text.dart';
import 'package:gemmy/widgets/ez/textfield.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

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
          const EdgeInsets.only(bottom: 8),
          <Widget>[
            SizedBox(
              width: 512,
              child: EzTextField(
                enabled: _step1Enabled,
                hintText: 'Put your API key here... I\'m not looking!',
                obscureText: true,
                disableSubmitButton: true,
                onChanged: (text) {
                  text = text.trim();

                  if (text.isEmpty) {
                    Globals.prefs.remove('apiKey');
                    Globals.reload();
                    setState(() => _step2Enabled = false);
                    return;
                  }

                  Globals.prefs.setString('apiKey', text);
                  Globals.reload();
                  setState(() => _step2Enabled = true);
                },
              ),
            ),
            SizedBox(
              width: 150,
              height: 42,
              child: EzButton(
                onPressed: _step2Enabled
                    ? () async {
                        setState(() {
                          _step1Enabled = false;
                          _step2Enabled = false;
                          _step2Loading = true;
                        });

                        try {
                          await Globals.model!
                              .generateContent([Content.text('Hi!')]);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: EzText('Connected!'),
                            ),
                          );

                          Navigator.of(context).pushReplacementNamed('/');
                        } catch (_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: EzText('Failed!'),
                            ),
                          );

                          setState(() {
                            _step1Enabled = true;
                            _step2Enabled = true;
                            _step2Loading = false;
                          });
                        }
                      }
                    : null,
                child: _step2Loading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(),
                      )
                    : EzText(
                        'Connect',
                        color: _step2Enabled ? Colors.white : Colors.white54,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
