import '../models/chat_message_model.dart';

abstract class ChatbotRemoteDataSource {
  Future<ChatMessageModel> sendMessage({
    required String chatId,
    required String messageContent,
    required List<ChatMessageModel> history,
  });
}
