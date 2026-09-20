import 'package:equatable/equatable.dart';

enum MessageSender { user, ai }

class ChatMessageEntity extends Equatable {
  const ChatMessageEntity({
    required this.id,
    required this.content,
    required this.sender,
    required this.timestamp,
    this.isError = false,
  });

  final String id;
  final String content;
  final MessageSender sender;
  final DateTime timestamp;
  final bool isError;

  ChatMessageEntity copyWith({
    String? id,
    String? content,
    MessageSender? sender,
    DateTime? timestamp,
    bool? isError,
  }) {
    return ChatMessageEntity(
      id: id ?? this.id,
      content: content ?? this.content,
      sender: sender ?? this.sender,
      timestamp: timestamp ?? this.timestamp,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props => [id, content, sender, timestamp, isError];
}
