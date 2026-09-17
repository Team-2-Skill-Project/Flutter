import '../../domain/entities/chat_message_entity.dart';

class ChatMessageModel extends ChatMessageEntity {
  const ChatMessageModel({
    required super.id,
    required super.content,
    required super.sender,
    required super.timestamp,
    super.isError = false,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] as String,
      content: json['content'] as String,
      sender: json['sender'] == 'user' ? MessageSender.user : MessageSender.ai,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isError: json['isError'] as bool? ?? false,
    );
  }

  factory ChatMessageModel.fromEntity(ChatMessageEntity entity) {
    return ChatMessageModel(
      id: entity.id,
      content: entity.content,
      sender: entity.sender,
      timestamp: entity.timestamp,
      isError: entity.isError,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'sender': sender == MessageSender.user ? 'user' : 'ai',
      'timestamp': timestamp.toIso8601String(),
      'isError': isError,
    };
  }
}
