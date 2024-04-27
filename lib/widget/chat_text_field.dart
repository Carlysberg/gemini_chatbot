import 'package:flutter/material.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({
    this.focusNode,
    this.isReadOnly = false,
    required this.textEditingController,
    required this.onFieldSubmitted,
    super.key,
  });

  final FocusNode? focusNode;
  final TextEditingController textEditingController;
  final bool isReadOnly;
  final void Function(String)? onFieldSubmitted;

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      autocorrect: false,
      controller: widget.textEditingController,
      focusNode: widget.focusNode,
      readOnly: widget.isReadOnly,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        hintText: "Yo dumb ass",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Ka biibi senior";
        }
        return null;
      },
    );
  }
}
