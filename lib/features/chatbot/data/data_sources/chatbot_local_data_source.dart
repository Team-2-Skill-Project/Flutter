import '../models/chat_model.dart';

abstract class ChatbotLocalDataSource {
  Future<List<ChatModel>> getChatSessions();
  Future<ChatModel?> getChatSession(String chatId);
  Future<void> saveChatSession(ChatModel chat);
  Future<void> deleteChatSession(String chatId);
  Future<void> clearAllChatSessions();
}
