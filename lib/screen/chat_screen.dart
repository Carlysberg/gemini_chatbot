import 'package:flutter/material.dart';
import 'package:gemini_chatbot/utils/api_key.dart';
import 'package:gemini_chatbot/widget/chat_text_field.dart';
import 'package:gemini_chatbot/widget/message_widget.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final GenerativeModel _model;
  late ChatSession _chatSession;
  late final ScrollController _scrollController;
  late final TextEditingController _textEditingController;
  late final FocusNode _focusNode;
  late bool _isLoading;

  @override
  void initState() {
    _model = GenerativeModel(model: geminiModel, apiKey: apiKey);
    _scrollController = ScrollController();
    _focusNode = FocusNode();
    _chatSession = _model.startChat();
    _textEditingController = TextEditingController();
    _isLoading = false;
    super.initState();
  }

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendChatMessage(String message) async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _setLoading(true);
    try {
      var response = await _chatSession.sendMessage(Content.text(message));
      final text = response.text;
      if (text == null) {
        _showError("No response was found");
        _setLoading(false);
      } else {
        _setLoading(false);
      }
    } catch (e) {
      _showError(e.toString());
      _setLoading(false);
    } finally {
      _textEditingController.clear();
      _focusNode.requestFocus();
      _setLoading(false);
    }
  }

  void _showError(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            scrollable: true,
            content: SingleChildScrollView(
              child: Text(message),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              )
            ],
          );
        });
  }

  String _getMessageFromContent(Content content) {
    return content.parts.whereType<TextPart>().map((e) => e.text).join("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
            controller: _scrollController,
            itemCount: _chatSession.history.length,
            itemBuilder: (context, index) {
              var content = _chatSession.history.toList()[index];
              final message = _getMessageFromContent(content);
              return MessageWidget(
                  message: message, isFromUser: content.role == "user");
            }),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Flexible(
                flex: 3,
                child: Form(
                  key: _formKey,
                  child: ChatTextField(
                    textEditingController: _textEditingController,
                    focusNode: _focusNode,
                    onFieldSubmitted: _sendChatMessage,
                    isReadOnly: _isLoading,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              if (!_isLoading) ...[
                ElevatedButton(
                  onPressed: () {
                    _sendChatMessage(_textEditingController.text);
                  },
                  child: const Text("WƆSO"),
                ),
              ] else ...[
                const CircularProgressIndicator()
              ]
            ],
          ),
        ),
      ),
    );
  }
}
