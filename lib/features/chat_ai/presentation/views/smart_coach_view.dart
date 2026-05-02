import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/screen_image_background.dart';
import 'package:super_fitness/features/chat_ai/presentation/view_model/chat_state.dart';
import 'package:super_fitness/features/chat_ai/presentation/view_model/chat_view_model.dart';
import 'package:super_fitness/features/chat_ai/presentation/widgets/chat_app_bar.dart';
import 'package:super_fitness/features/chat_ai/presentation/widgets/chat_drawer.dart';
import 'package:super_fitness/features/chat_ai/presentation/widgets/message_sender.dart';

class SmartCoachChatView extends StatefulWidget {
  const SmartCoachChatView({super.key});

  @override
  State<SmartCoachChatView> createState() => _SmartCoachChatViewState();
}

class _SmartCoachChatViewState extends State<SmartCoachChatView> {
  late final TextEditingController _chatController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _chatController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _chatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return ScreenImageBackground(
      imagePath: AssetsManager.smartChatBg,
      drawer: ChatDrawer(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ChatAppBar(),
              BlocBuilder<ChatViewModel, ChatState>(
                builder: (context, state) {
                  final messages = state.message.data ?? [];
                  if (messages.isNotEmpty) {
                    _scrollToBottom();
                  }
                  return messages.isEmpty
                      ? Expanded(child: SizedBox.shrink())
                      : Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  controller: _scrollController,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 24),
                                  itemCount: messages.length,
                                  itemBuilder: (context, index) {
                                    final message = messages[index];
                                    return MessageSender(
                                      text: message.text,
                                      isUser: message.isUser,
                                      timestamp: DateTime.now(),
                                    );
                                  },
                                ),
                              ),
                              if (state.message.isError)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.red),
                                    ),
                                    child: Text(
                                      state.message.errorMessage ??
                                          'chat.error'.tr(),
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                },
              ),

              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _chatController,
                        decoration: InputDecoration(
                          hintText: 'chat.typeAMessage'.tr(),
                          enabledBorder: _buildChatBorder(),
                          focusedBorder: _buildChatBorder(),
                          border: _buildChatBorder(),
                        ),
                      ),
                    ),
                    BlocBuilder<ChatViewModel, ChatState>(
                      builder: (context, state) => state.message.isLoading
                          ? SizedBox(
                              width: 48,
                              height: 48,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                final message = _chatController.text.trim();
                                if (message.isEmpty) return;
                                context.read<ChatViewModel>().doIntent(
                                  SendMessageIntent(message),
                                );
                                _chatController.clear();
                              },
                              icon: Icon(Icons.send, color: theme.primary),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _buildChatBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Color(0xFFFF6A00)),
  );
}
