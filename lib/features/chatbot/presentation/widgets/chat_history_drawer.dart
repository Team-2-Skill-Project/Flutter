import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../domain/entities/chat_entity.dart';
import '../cubit/chatbot_cubit.dart';
import '../cubit/chatbot_state.dart';

class ChatHistoryDrawer extends StatelessWidget {
  const ChatHistoryDrawer({super.key});

  Map<String, List<ChatEntity>> _groupChats(
    BuildContext context,
    List<ChatEntity> chats,
  ) {
    final s = S.of(context);
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final yesterdayStart = todayStart.subtract(const Duration(days: 1));
    final weekStart = todayStart.subtract(const Duration(days: 7));

    final Map<String, List<ChatEntity>> grouped = {
      s.today: [],
      s.yesterday: [],
      s.previous7Days: [],
      s.older: [],
    };

    for (final chat in chats) {
      if (chat.updatedAt.isAfter(todayStart)) {
        grouped[s.today]!.add(chat);
      } else if (chat.updatedAt.isAfter(yesterdayStart)) {
        grouped[s.yesterday]!.add(chat);
      } else if (chat.updatedAt.isAfter(weekStart)) {
        grouped[s.previous7Days]!.add(chat);
      } else {
        grouped[s.older]!.add(chat);
      }
    }

    // Remove empty groups
    grouped.removeWhere((key, value) => value.isEmpty);
    return grouped;
  }

  void _showDeleteConfirmDialog(BuildContext context, ChatEntity chat) {
    final s = S.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s.deleteChat),
        content: Text(s.confirmDeleteChat),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(s.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(ctx);
              context.read<ChatbotCubit>().deleteChat(chat.id);
            },
            child: Text(s.delete, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showClearAllConfirmDialog(BuildContext context) {
    final s = S.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s.clearAllChats),
        content: Text(s.confirmClearAllChats),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(s.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(ctx);
              context.read<ChatbotCubit>().clearAllChats();
            },
            child: Text(s.clear, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Drawer(
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header with New Chat
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        color: theme.primaryColor,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        s.chatHistory,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<ChatbotCubit>().initializeChat();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: Text(
                        s.newChat,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // History List
            Expanded(
              child: BlocBuilder<ChatbotCubit, ChatbotState>(
                builder: (context, state) {
                  final grouped = _groupChats(context, state.chatHistory);

                  if (state.chatHistory.isEmpty) {
                    return Center(
                      child: Text(
                        'No history yet',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: grouped.length,
                    itemBuilder: (context, index) {
                      final groupTitle = grouped.keys.elementAt(index);
                      final chats = grouped[groupTitle]!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Text(
                              groupTitle,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ...chats.map((chat) {
                            final isSelected = chat.id == state.activeChatId;
                            return ListTile(
                              dense: true,
                              selected: isSelected,
                              selectedTileColor: theme.primaryColor.withValues(
                                alpha: 0.1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 2.0,
                              ),
                              leading: Icon(
                                Icons.chat_bubble_outline_rounded,
                                size: 18,
                                color: isSelected
                                    ? theme.primaryColor
                                    : Colors.grey[600],
                              ),
                              title: Text(
                                chat.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isSelected ? theme.primaryColor : null,
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete_outline_rounded,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                onPressed: () =>
                                    _showDeleteConfirmDialog(context, chat),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                context.read<ChatbotCubit>().selectChat(
                                  chat.id,
                                );
                              },
                            );
                          }),
                        ],
                      );
                    },
                  );
                },
              ),
            ),

            const Divider(height: 1),
            // Clear All Button
            BlocBuilder<ChatbotCubit, ChatbotState>(
              builder: (context, state) {
                if (state.chatHistory.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton.icon(
                    onPressed: () => _showClearAllConfirmDialog(context),
                    icon: const Icon(
                      Icons.delete_sweep_rounded,
                      color: Colors.red,
                      size: 20,
                    ),
                    label: Text(
                      s.clearAllChats,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
