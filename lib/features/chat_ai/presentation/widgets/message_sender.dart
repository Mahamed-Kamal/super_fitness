import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';

class MessageSender extends StatelessWidget {
  const MessageSender({
    super.key,
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
  final String text;
  final bool isUser;
  final DateTime timestamp;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Row(
      mainAxisAlignment: isUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isUser) ...[CircleAvatar(radius: 16), SizedBox(width: 8)],
        Flexible(
          child: Container(
            padding: EdgeInsets.all(12),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: isUser ? _isUserDecoration() : _isChatDecoration(),
            child: text == 'Typing...'
                ? Skeletonizer(
                    enabled: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: 200, height: 16, color: Colors.white),
                        SizedBox(height: 8),
                        Container(width: 150, height: 16, color: Colors.white),
                        SizedBox(height: 8),
                        Container(width: 180, height: 16, color: Colors.white),
                      ],
                    ),
                  )
                : Text(
                    text,
                    style: theme.regular16.copyWith(fontSize: 16),
                    textAlign: isUser ? TextAlign.right : TextAlign.left,
                  ),
          ),
        ),
        if (isUser) ...[SizedBox(width: 8), CircleAvatar(radius: 16)],
      ],
    );
  }

  BoxDecoration _isChatDecoration() => BoxDecoration(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(18),
      bottomRight: Radius.circular(18),
      bottomLeft: Radius.circular(18),
    ),
    color: Color(0xFF242424),
  );

  BoxDecoration _isUserDecoration() => BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(18),
      bottomRight: Radius.circular(18),
      bottomLeft: Radius.circular(18),
    ),
    color: Color(0xFFFF6A00),
  );
}
