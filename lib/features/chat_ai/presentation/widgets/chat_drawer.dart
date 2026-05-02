import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:super_fitness/core/extensions/data_time_extension.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/features/chat_ai/presentation/view_model/chat_state.dart';
import 'package:super_fitness/features/chat_ai/presentation/view_model/chat_view_model.dart';

class ChatDrawer extends StatelessWidget {
  const ChatDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'chat.previousConversations'.tr(),
                    style: theme.semiBold24.copyWith(fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<ChatViewModel>().doIntent(
                        StartNewConversationIntent(),
                      );
                      Navigator.pop(context); // Close drawer
                    },
                    icon: Icon(Icons.add, color: theme.primary),
                    tooltip: 'chat.newConversation'.tr(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<ChatViewModel, ChatState>(
                builder: (context, state) {
                  if (state.conversations.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state.conversations.isError) {
                    return Center(
                      child: Text(
                        'chat.failedLoadConversations'.tr(),
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  final conversations = state.conversations.data ?? [];
                  if (conversations.isEmpty) {
                    return Center(
                      child: Text(
                        'chat.noPreviousConversations'.tr(),
                        style: theme.regular16,
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      final conversation = conversations[index];
                      final isCurrent =
                          state.currentConversation?.id == conversation.id;

                      return ListTile(
                        leading: Icon(
                          Icons.arrow_back_ios_new_sharp,
                          color: theme.primary,
                        ),

                        title: Text(
                          conversation.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.medium16.copyWith(
                            fontWeight: isCurrent
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        subtitle: Text(
                          conversation.lastUpdated.formatDate(),
                          style: theme.regular14.copyWith(color: Colors.grey),
                        ),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'delete') {
                              context.read<ChatViewModel>().doIntent(
                                DeleteConversationIntent(conversation.id),
                              );
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text('chat.delete'.tr()),
                                ],
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          context.read<ChatViewModel>().doIntent(
                            LoadConversationIntent(conversation.id),
                          );
                          Navigator.pop(context); // Close drawer
                        },
                        selected: isCurrent,
                        selectedTileColor: theme.primary.withValues(alpha: 0.1),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
