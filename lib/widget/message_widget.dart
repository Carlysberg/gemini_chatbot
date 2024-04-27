import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget(
      {super.key, required this.message, required this.isFromUser});

  final String message;
  final bool isFromUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
            child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).width -
                MediaQuery.sizeOf(context).width / 5,
          ),
          decoration: BoxDecoration(
            color: isFromUser
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 12,
          ),
          margin: const EdgeInsets.only(bottom: 8),
          child: MarkdownBody(
            data: message,
            selectable: true,
          ),
        )),
      ],
    );
  }
}
