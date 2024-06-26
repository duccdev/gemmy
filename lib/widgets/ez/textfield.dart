import 'package:flutter/material.dart';

typedef OnSubmittedCallback = void Function(String text);
typedef OnChangedCallback = void Function(String text);

class EzTextField extends StatefulWidget {
  const EzTextField({
    super.key,
    this.onSubmitted,
    this.onChanged,
    this.disableSubmitButton,
    this.hintText,
    this.obscureText,
    this.defaultValue,
    this.enabled,
  });

  final OnSubmittedCallback? onSubmitted;
  final OnChangedCallback? onChanged;
  final bool? disableSubmitButton;
  final String? hintText;
  final bool? obscureText;
  final String? defaultValue;
  final bool? enabled;

  @override
  State<EzTextField> createState() => _EzTextFieldState();
}

class _EzTextFieldState extends State<EzTextField> {
  bool _sendButtonDisabled = true;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_onTextChanged);
    _controller.text = widget.defaultValue ?? '';
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      if (widget.onChanged != null) {
        widget.onChanged!(_controller.text);
      }

      if (_controller.text.trim().isNotEmpty) {
        _sendButtonDisabled = false;
        return;
      }

      _sendButtonDisabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(9999),
        right: Radius.circular(9999),
      ),
    );

    return SizedBox(
      height: 48,
      child: TextField(
        enabled: widget.enabled,
        controller: _controller,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF282A2C),
          border: border,
          focusedBorder: border,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Color(0xFFBABDC2),
            fontWeight: FontWeight.w600,
          ),
          suffixIcon: (widget.disableSubmitButton ?? false)
              ? null
              : Padding(
                  padding: const EdgeInsets.all(4),
                  child: IconButton.filled(
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 24,
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        _sendButtonDisabled ? Colors.grey : Colors.green,
                      ),
                    ),
                    onPressed: _sendButtonDisabled
                        ? null
                        : () {
                            if (widget.onSubmitted == null) return;
                            widget.onSubmitted!(_controller.text);
                            _controller.text = '';
                          },
                  ),
                ),
        ),
        obscureText: widget.obscureText ?? false,
        cursorColor: Colors.white,
      ),
    );
  }
}
